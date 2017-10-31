import Foundation
import Dispatch
import DotEnv

public struct ConstitutionManager {
  /// The markdown of the constitution from the GitHub repository
  public static var mdConstitution: String = "For some reason the constitution cannot be displayed, please contact the site administrators."

  /// Used to avoid multiple git pulls being run simultaneously
  private static let serialQueue = DispatchQueue(label: "com.hac.website.const-pull-queue")

  private static let dataDirectory = "constitution"

  /**
    Ensures that an up-to-date copy of the constitution repo is available locally
    We don't want this function running many times concurrently, hence 'unsafe'
  */
  private static func unsafePull() {
    GitUtils.cloneOrPull(
      repoURL: "https://github.com/hackersatcambridge/constitution.git",
      in: DotEnv.get("DATA_DIR")!,
      directory: dataDirectory
    )
  }

  /**
    Grabs the constitution markdown and loads it into a string.

    - throws: If the constitution directory does not exist
  */
  private static func getConstitution() throws {
    let constitutionPath = DotEnv.get("DATA_DIR")! + "/\(dataDirectory)/constitution.md"
      do {
        let constitutionMarkdown = try String(contentsOfFile: constitutionPath, encoding: .utf8)
        mdConstitution = constitutionMarkdown
      } catch {
      }
  }

  /**
    Update the constitution by pulling changes from the repo.
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
