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
  private let directoryName: String

  public var localRepoPath: String {
    return cloneRoot + "/" + directoryName
  }

  init(remoteRepoURL: String, directoryName: String) {
    serialQueue = DispatchQueue(label: "com.hac.website.\(directoryName)-pull-queue")
    self.remoteRepoURL = remoteRepoURL
    self.directoryName = directoryName
  }

  /// A safe version of `unsafeUpdate`
  public func update(then callback: @escaping () throws -> Void = {}) rethrows {
    // Use a serial queue to avoid concurrent Git processes in the same directory
    try serialQueue.sync {
      unsafeUpdate()
      try callback()
    }
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
    The exit code of the command
*/
@discardableResult
private func shell(args: String...) -> Int32 {
  let task = Process()
  task.launchPath = "/usr/bin/env"
  task.arguments = args
  task.launch()
  task.waitUntilExit()
  return task.terminationStatus
}
