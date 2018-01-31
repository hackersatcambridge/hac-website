import HaCWebsiteLib
import DotEnv
import Foundation

DotEnv.load()
Config.checkEnvVars()

// swiftlint:disable:next force_try
ConstitutionManager.update()
NewWorkshopManager.update()
NewWorkshopManager.startPoll()

// This call never returns
serveWebsite()
