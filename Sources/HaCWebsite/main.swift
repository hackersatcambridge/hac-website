import HaCWebsiteLib
import DotEnv
import Foundation

DotEnv.load()
Config.checkEnvVars()

// swiftlint:disable:next force_try
WorkshopManager.update()
ConstitutionManager.update()

// This call never returns
serveWebsite()
