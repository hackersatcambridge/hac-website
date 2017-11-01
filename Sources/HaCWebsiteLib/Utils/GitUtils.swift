import Foundation

public struct GitUtils {
  /**
    Runs a `git clone` command at the specified path, cloning into the specified directory

    - parameters:
      - repoURL: The URL to the Git repository to clone
      - localPath: The local path in which to run the `clone`
      - directory: The directory name to clone the repository into
  */
  public static func shallowBranchClone(
    repoURL: String,
    in localPath: String,
    directory: String,
    branch: String = "master"
  ) {
    let repoPath = localPath + "/" + directory
    shell(args: "git", "clone", "--depth", "1", repoURL, repoPath, "--branch", branch, "--single-branch")
  }

  /**
    Runs a `git pull` command at the specified path

    - parameters:
      - in: The path to the local repository in which to pull
      - remote: The name of the remote to pull from
      - branch: The name of the branch on the remote to pull from
  */
  public static func pull(in localRepoPath: String, remote: String = "origin", branch: String = "master") {
    // Note the -C argument which tells Git to move to the following directory before doing anything
    shell(args: "git", "-C", localRepoPath, "pull", remote, branch)
  }

  /**
    Clones a Git repository if it doesn't already exist at the specified location, updating it otherwise

    - parameters:
      - repoURL: The URL to the Git repository
      - localPath: The local path to the parent directory of the repository
      - directory: The directory name to clone or pull the repository into
  */
  public static func cloneOrPull(repoURL: String, in localPath: String, directory: String) {
    let localRepoPath = localPath + "/" + directory
    guard directoryExists(atPath: localRepoPath) else {
      shallowBranchClone(
        repoURL: repoURL,
        in: localPath,
        directory: directory
      )

      return
    }

    pull(in: localRepoPath)
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

private func directoryExists(atPath: String) -> Bool {
  // Note the Objective-C gunk here, an unfortunate part of this API
  var isDirectory: ObjCBool = ObjCBool(false)
  let fileExists = FileManager.default.fileExists(atPath: atPath, isDirectory: &isDirectory)

  return fileExists && isDirectory.description == "true"
}
