import Foundation
import Kitura
import DotEnv
import SwiftyJSON
import LoggerAPI
import HeliumLogger
import HaCTML
import Fluent
import PostgreSQLDriver

func getWebsiteRouter() -> Router {
  let router = Router()

  router.all("/", middleware: RedirectsMiddleware(redirects: [
    "/intro-to-programming": "https://github.com/hackersatcambridge/intro-to-programming",
    "/bash": "https://github.com/hackersatcambridge/workshops/blob/master/workshops/tools_for_programmers/01_intro_to_bash/description.md",
    "/git": "https://github.com/hackersatcambridge/git-workshop-2017",
    "/make-games-with-love": "https://github.com/hackersatcambridge/make-games-with-love",
    "/game-gig": "https://hackersatcambridge.com/hackathons/2017/game-gig-3000"
  ]))

  router.all("/static", middleware: StaticFileServer(path: "./static/dist"))

  /// Intended for use by GitHub webhooks
  router.post("/api/refresh_workshops", handler: GitHubWebhookController.handler(updater: WorkshopManager.update))
  router.post("/api/refresh_constitution", handler: GitHubWebhookController.handler(updater: ConstitutionManager.update))
  router.post("/api/add_event", allowPartialMatch: false, middleware: BodyParser())
  router.post("/api/add_event", middleware: CredentialsServer.credentials)
  router.post("/api/add_event", handler: EventApiController.handler) 

  router.get("/", handler: LandingPageController.handler)
  router.get("/workshops", handler: WorkshopsController.handler)
  router.get("/constitution", handler: ConstitutionController.handler)

  // MARK: Features in progress
  router.get("/beta/landing-update-feed", handler: LandingUpdateFeedController.handler)

  router.all("/", middleware: NotFoundMiddleware())


  return router
}

public func serveWebsite() {
  DatabaseUtils.prepareDatabase()
  // Helium logger provides logging for Kitura processes
  HeliumLogger.use()
  // This speaks to Kitura's 'LoggerAPI' to set the default logger to HeliumLogger.
  // Kitura calls this API to log things

  Kitura.addHTTPServer(onPort: Config.listeningPort, with: getWebsiteRouter())
  Kitura.run() // This call never returns
}
