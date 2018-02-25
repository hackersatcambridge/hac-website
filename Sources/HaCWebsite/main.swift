import HaCWebsiteLib
import DotEnv
import Foundation

DotEnv.load()
Config.checkEnvVars()

// swiftlint:disable:next force_try
ConstitutionManager.update()
BlogPostManager.update()
WorkshopManager.update()
WorkshopManager.startPoll()

// This call never returns
serveWebsite()
