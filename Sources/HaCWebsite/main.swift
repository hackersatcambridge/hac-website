import HaCWebsiteLib
import DotEnv
import Foundation

DotEnv.load()

// Check for required env vars
guard let _ = DotEnv.get("DATA_DIR") else {
  fatalError("Missing environment variable")
}

try! WorkshopManager.update()

// This call never returns
serveWebsite()