import Foundation
import Dispatch
import DotEnv

public struct ConstitutionManager {
  /// The list of workshops as derived from the workshops directory last time it was updated
  public static var mdConstitution: String = "Baby got HaC"

  /// Used to avoid multiple git pulls being run simultaneously
  private static let serialQueue = DispatchQueue(label: "com.hac.website.const-pull-queue")

  private static let data_directory = "constitution"

  /**
    Ensures that an up-to-date copy of the workshops repo is available locally
    We don't want this function running many times concurrently, hence 'unsafe'
  */
  private static func unsafePull() {
    GitUtils.cloneOrPull(
      repoURL: "https://github.com/hackersatcambridge/constitution.git",
      in: DotEnv.get("DATA_DIR")!,
      directory: data_directory
    )
  }

  /**
    Parses each workshop from the workshops repo, creating a Workshop instance
    These are stored publicly in WorkshopManager.workshops

    - throws: If the workshops directory does not exist
  */
  private static func getConstitution() throws {
    let constitutionPath = DotEnv.get("DATA_DIR")! + "/\(data_directory)/constitution.md"
      do {
        let constitutionMarkdown = try String(contentsOfFile: constitutionPath, encoding: .utf8)
        mdConstitution = constitutionMarkdown
      } catch {
      }
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
      try getConstitution()
    }
  }
}
