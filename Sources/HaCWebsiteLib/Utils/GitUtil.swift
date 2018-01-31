import Foundation
import Dispatch
import DotEnv

/// A utility to manage read-only interactions with external Git repos
public struct GitUtil {
  /// Used to avoid multiple git pulls being run simultaneously
  private let serialQueue: DispatchQueue

  /// The directory that will hold all the repos we clone
  private let cloneRoot = DotEnv.get("DATA_DIR")!

  private let remoteRepoURL: String

  /// The name of the directory within the clone root where this repo will be held
  private let directoryName: String

  /// The local path at which the utility will store and update the repo contents
  public var localRepoPath: String {
    return cloneRoot + "/" + directoryName
  }

  init(remoteRepoURL: String, directoryName: String) {
    serialQueue = DispatchQueue(label: "com.hac.website.\(directoryName)-pull-queue")
    self.remoteRepoURL = remoteRepoURL
    self.directoryName = directoryName
  }

  /// A synchronous, thread-safe call to pull the latest version of the repository to disk
  public func update() {
    // Use a serial queue to avoid concurrent Git processes in the same directory
    serialQueue.sync {
      unsafeUpdate()
    }
  }

  public func getHeadCommitSha() -> String {
    let (shaWithNewline, _) = shell(args: "git", "-C", localRepoPath, "rev-parse", "HEAD")

    return shaWithNewline!.replacingOccurrences(of: "\n", with: "")
  }

  /// Clones the repository if it doesn't already exist at the specified location, updating it otherwise
  private func unsafeUpdate() {
    /**
     * Here we assume that if we have a directory at this path,
     * it is a checkout of the repository in question and we will be able to pull updates.
     */
    if localDirectoryExists() {
      pull()
    } else {
      shallowBranchClone()
    }
  }

  /// Runs a `git clone` command at the specified path, cloning into the specified directory
  private func shallowBranchClone() {
    shell(args: "git", "clone", "--depth", "1", remoteRepoURL, localRepoPath, "--single-branch")
  }

  /// Runs a `git pull` command at the repo path
  private func pull() {
    // Note the -C argument which tells Git to move to the following directory before doing anything
    shell(args: "git", "-C", localRepoPath, "pull", remoteRepoURL)
  }

  private func localDirectoryExists() -> Bool {
    // Note the Objective-C gunk here, an unfortunate part of this API
    var isDirectory: ObjCBool = ObjCBool(false)
    let fileExists = FileManager.default.fileExists(atPath: localRepoPath, isDirectory: &isDirectory)

    return fileExists && isDirectory.description == "true"
  }
}

/**
  Executes a shell command synchronously, returning the exit code

  - parameters:
    - args: The arguments to the shell command, starting with the command itself

  - returns:
    The output of the command and the exit code as a tuple
  
  Taken from: https://stackoverflow.com/a/31510860
*/
@discardableResult
private func shell(args: String...) -> (String? , Int32) {
  let task = Process()
  task.launchPath = "/usr/bin/env"
  task.arguments = args

  let pipe = Pipe()
  task.standardOutput = pipe
  task.standardError = pipe
  task.launch()

  let data = pipe.fileHandleForReading.readDataToEndOfFile()
  let output = String(data: data, encoding: .utf8)
  task.waitUntilExit()

  return (output, task.terminationStatus)
}
