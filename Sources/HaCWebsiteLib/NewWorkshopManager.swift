import Foundation
import DotEnv
import Dispatch
import Yaml

public struct NewWorkshopManager {
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

  /// The list of Workshops as derived from the workshop repos last time they were processed. Keys are workshop repo names
  public private(set) static var workshops: [String: NewWorkshop] = [:]

  /// All the workshop repos that we know about. Keys are workshop repo names
  private static var workshopRepoUtils: [String: GitUtil] = [:]

  public static func update() {
    updateRepoList()
    updateWorkshopsData()
  }

  /// Update the list of workshop repositories synchronously. This does not update the workshops themselves
  public static func updateRepoList() {
    // Pull all the repos referenced by that
    do {
      let indexYamlString = try String(
        contentsOf: URL(
          string: "https://raw.githubusercontent.com/hackersatcambridge/workshops-refactor/master/workshops.yaml"
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

  public static func updateWorkshopsData() {
    let updateDispatchGroup = DispatchGroup()

    for (repoName, repoUtil) in workshopRepoUtils {
      updateDispatchGroup.enter()
      updateQueue.async {
        do {
          repoUtil.update()
          let updatedWorkshop = try NewWorkshop(localPath: repoUtil.localRepoPath)
          workshops[repoName] = updatedWorkshop
        } catch {
          print(error)
        }
        updateDispatchGroup.leave()
      }
    }

    // Wait for all to finish
    updateDispatchGroup.wait()
  }
}
