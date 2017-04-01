import HaCWebsiteLib
import DotEnv
import Foundation

DotEnv.load()
Config.checkEnvVars()

try! WorkshopManager.update()

// This call never returns
serveWebsite()