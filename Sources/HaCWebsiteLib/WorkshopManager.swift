import Foundation
import DotEnv
import Dispatch
import Yaml

public struct WorkshopManager {
  public enum Error: Swift.Error {
    case updateFailed(String)
  }

  private static let directoryName = "workshops"

  /// A concurrent queue used for parallelising workshop data updates
  private static var updateQueue = DispatchQueue(
    label: "com.hac.website.workshops-update-queue",
    qos: .background,
    attributes: .concurrent
  )

  private static var pollSource: DispatchSourceTimer! = nil
  private static var currentlyUpdating = false

  /// The list of Workshops as derived from the workshop repos last time they were processed. Keys are workshop repo names
  public private(set) static var workshops: [String: Workshop] = [:]

  /// All the workshop repos that we know about. Keys are workshop repo names
  private static var workshopRepoUtils: [String: GitUtil] = [:]

  public static func update() {
    print("Updating workshops...")
    // Prevent multiple updates at once (might happen if an update takes longer than the poll interval)
    if !currentlyUpdating {
      currentlyUpdating = true
      updateRepoList()
      updateWorkshopsData()
      currentlyUpdating = false
    }
    print("Workshops updated")
  }

  public static func startPoll() {
    let pollQueue = DispatchQueue(label: "com.hac.website.workshops-poll-timer", attributes: .concurrent)
    pollSource?.cancel()
    pollSource = DispatchSource.makeTimerSource(queue: pollQueue)
    pollSource.setEventHandler {
      update()
    }
    pollSource.schedule(
      deadline: DispatchTime.now(),
      repeating: .seconds(10),
      leeway: .seconds(2)
    )
    pollSource.resume()
  }

  /// Update the list of workshop repositories synchronously. This does not update the workshops themselves
  public static func updateRepoList() {
    // Pull all the repos referenced by that
    do {
      let indexYamlString = try String(
        contentsOf: URL(
          string: "https://raw.githubusercontent.com/hackersatcambridge/workshops/master/workshops.yaml"
        )!,
        encoding: .utf8
      )
      let indexYaml = try Yaml.load(indexYamlString)
      let workshopURLs = try stringsArray(for: "workshops", in: indexYaml)
      for workshopURL in workshopURLs {
        let repoName = workshopURL.components(separatedBy: "/").last ?? workshopURL
        if workshopRepoUtils[repoName] == nil {
          workshopRepoUtils[repoName] = GitUtil(
            remoteRepoURL: workshopURL,
            directoryName: repoName
          )
        }
      }
    } catch {
      print("Failed to update workshops index")
      dump(error)
    }
  }

  fileprivate static func stringsArray(for key: Yaml, in metadata: Yaml) throws -> [String] {
    guard let values = metadata[key].array else {
      throw Error.updateFailed("Couldn't find workshops index in workshops.yaml")
    }
    return try values.map({
      if let stringValue = $0.string {
        return stringValue
      } else {
        throw Error.updateFailed("Expected values in \(key) to be strings")
      }
    })
  }

  /// Update the in-memory copy of the workshops synchronously
  public static func updateWorkshopsData() {
    let updateDispatchGroup = DispatchGroup()

    for (repoName, repoUtil) in workshopRepoUtils {
      updateDispatchGroup.enter()
      updateQueue.async {
        do {
          repoUtil.update()
          let updatedWorkshop = try Workshop(localPath: repoUtil.localRepoPath, headCommitSha: repoUtil.getHeadCommitSha())
          workshops[repoName] = updatedWorkshop
        } catch {
          print("Failed to initialise workshop from repo: \(repoName)")
          dump(error)
        }
        updateDispatchGroup.leave()
      }
    }

    // Wait for all to finish
    updateDispatchGroup.wait()
  }
}
