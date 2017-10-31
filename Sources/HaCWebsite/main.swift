import HaCWebsiteLib
import DotEnv
import Foundation

DotEnv.load()
Config.checkEnvVars()

// swiftlint:disable:next force_try
try! WorkshopManager.update()
try! ConstitutionManager.update()

// This call never returns
serveWebsite()
