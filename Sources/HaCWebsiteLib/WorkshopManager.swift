import Foundation
import Dispatch
import DotEnv

public struct WorkshopManager {
  /// The list of workshops as derived from the workshops directory last time it was updated
  public private(set) static var workshops: [Workshop] = []

  /// Used to avoid multiple git pulls being run simultaneously
  private static let serialQueue = DispatchQueue(label: "com.hac.website.ws-pull-queue")

  /**
    Ensures that an up-to-date copy of the workshops repo is available locally
    We don't want this function running many times concurrently, hence 'unsafe'
  */
  private static func unsafePull() {
    GitUtils.cloneOrPull(repoURL: "https://github.com/hackersatcambridge/workshops.git", in: DotEnv.get("DATA_DIR")!, directory: "workshops")
  }

  /**
    Parses each workshop from the workshops repo, creating a Workshop instance
    These are stored publicly in WorkshopManager.workshops

    - throws: If the workshops directory does not exist
  */
  private static func processWorkshopFiles() throws {
    var updatedWorkshops: [Workshop] = []
    let workshopsPath = DotEnv.get("DATA_DIR")! + "/workshops/examples"

    let paths = try FileManager.default.contentsOfDirectory(atPath: workshopsPath)
    for path in paths {
      let absolutePath = workshopsPath + "/" + path

      let metadataPath = absolutePath + "/metadata.yaml"
      let descriptionPath = absolutePath + "/description.md"
      let prerequisitesPath = absolutePath + "/prerequisites.md"

      do {
        let metadataYaml = try String(contentsOfFile: metadataPath, encoding: .utf8)
        let descriptionMarkdown = try String(contentsOfFile: descriptionPath, encoding: .utf8)
        let prerequisitesMarkdown = try String(contentsOfFile: prerequisitesPath, encoding: .utf8)
         
        let newWorkshop = try Workshop.parse(
          metadataYaml: metadataYaml,
          descriptionMarkdown: descriptionMarkdown,
          prerequisitesMarkdown: prerequisitesMarkdown
        )
        updatedWorkshops.append(newWorkshop)
      } catch {
        continue
      }
    }
    workshops = updatedWorkshops
  }

  /**
    Update the workshops array by pulling changes from the repo.
    This should be called whenever it is likely that changes
    have been made to the repo.
  */
  public static func update() throws {
    // Use a serial queue to avoid concurrent Git processes
    try serialQueue.sync {
      unsafePull()
      try processWorkshopFiles()
    }
  }
}
