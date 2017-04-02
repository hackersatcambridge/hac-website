import Foundation

public struct GitUtils {
  /**
    Executes a shell command synchronously, returning the exit code
    
    - parameters:
      - args: The arguments to the shell command, starting with the command itself
      
    - returns:
      The exit code of the command
  */
  @discardableResult
  private static func shell(args: String...) -> Int32 {
      let task = Process()
      task.launchPath = "/usr/bin/env"
      task.arguments = args
      task.launch()
      task.waitUntilExit()
      return task.terminationStatus
  }

  /**
    Runs a `git clone` command at the specified path, cloning into the specified directory
    
    - parameters:
      - repoURL: The URL to the Git repository to clone
      - localPath: The local path in which to run the `clone`
      - directory: The directory name to clone the repository into
  */
  public static func shallowBranchClone(repoURL: String, in localPath: String, directory: String, branch: String = "master") {
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

    // Check if directory already exists
    // Note the Objective-C gunk here, an unfortunate part of this API
    var isDirectory: ObjCBool = ObjCBool(false)
    let fileExists = FileManager.default.fileExists(atPath: localRepoPath, isDirectory: &isDirectory)

    if fileExists && isDirectory.description == "true" {
      // Directory already exists, pull updates
      pull(in: localRepoPath)
    } else {
      // Directory does not yet exist, clone the repo
      shallowBranchClone(repoURL: "https://github.com/hackersatcambridge/workshops.git", in: localPath, directory: directory)
    }
  }
}
