import Foundation
import Dispatch
import DotEnv

public struct ConstitutionManager {
  /// The markdown of the constitution from the GitHub repository
  public static var mdConstitution: String = "For some reason the constitution cannot be displayed, please contact the site administrators."
  private static let directoryName = "constitution"
  private static let gitUtil = GitUtil(
    remoteRepoURL: "https://github.com/hackersatcambridge/constitution",
    directoryName: directoryName
  )

  /// Pulls any updates from the remote repo and updates the in-memory constitution
  public static func update() {
    gitUtil.update()
    do {
      try self.loadConstitution()
    } catch {
      print("Failed to load constitution from file")
    }
  }

  /**
    Grabs the constitution markdown and loads it into a string.

    - throws: If the constitution directory does not exist
  */
  private static func loadConstitution() throws {
    let constitutionPath = gitUtil.localRepoPath + "/constitution.md"
    let constitutionMarkdown = try String(contentsOfFile: constitutionPath, encoding: .utf8)
    mdConstitution = constitutionMarkdown
  }
}
