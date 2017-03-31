import Foundation;

struct Config {
  static func envVar(forKey key: String) -> String? {
    return ProcessInfo.processInfo.environment[key];
  }

  static var listeningPort: Int {
    if let portString = envVar(forKey: "PORT"), let port = Int(portString) {
      return port;
    }

    return 8090;
  }
}
