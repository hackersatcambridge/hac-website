import Foundation
import Dispatch
import DotEnv

public struct WorkshopManager {
  private static let directoryName = "workshops"

  /// The list of workshops as derived from the workshops directory last time it was updated
  public private(set) static var workshops: [Workshop] = []

  /// Update the `workshops` list
  public static func update() {
    do {
      try gitUtil.update(then: {
        try self.processWorkshopFiles()
      })
    } catch {
      print("Failed to process workshop files")
    }
  }

  private static let gitUtil = GitUtil(
    remoteRepoURL: "https://github.com/hackersatcambridge/workshops",
    directoryName: "workshops"
  )

  /**
    Parses each workshop from the workshops repo, creating a Workshop instance
    These are stored publicly in WorkshopManager.workshops

    - throws: If the workshops directory does not exist
  */
  private static func processWorkshopFiles() throws {
    var updatedWorkshops: [Workshop] = []
    let workshopsPath = gitUtil.localRepoPath + "/examples"

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


}
