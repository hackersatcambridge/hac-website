import Foundation
import Kitura
import KituraCompression
import DotEnv
import SwiftyJSON
import LoggerAPI
import HeliumLogger
import HaCTML

func getWebsiteRouter() -> Router {
  let router = Router()

  router.all("/", middleware: RedirectsMiddleware(redirects: [
    "/intro-to-programming": "https://github.com/hackersatcambridge/intro-to-programming",
    "/bash": "https://github.com/hackersatcambridge/workshops/blob/master/workshops/tools_for_programmers/01_intro_to_bash/description.md",
    "/git": "https://github.com/hackersatcambridge/git-workshop-2017",
    "/binary-exploitation": "https://github.com/hackersatcambridge/binary-exploitation/blob/master/handout.md",
    "/love": "https://github.com/hackersatcambridge/workshop-love2d/blob/master/content/notes/notes.md",
    "/game-gig": "/events/2017/gamegig3000",
    "/gamegig": "/events/2017/gamegig3000",
    "/unity": "https://github.com/hackersatcambridge/workshop-unity/blob/master/content/notes/notes.md"
  ]))

  let assetsConfig = Assets.AssetsConfig(urlBase: "/static")
  Assets.initialize(config: assetsConfig)
  router.all(assetsConfig.urlBase, middleware: Assets.fileServingMiddleware)

  /// Intended for use by GitHub webhooks
  router.post("/api/refresh_constitution", handler: GitHubWebhookController.handler(updater: ConstitutionManager.update))

  // Used to add events to the database (see `/Docs/Api` for documentation)
  router.post("/api/add_event", allowPartialMatch: false, middleware: BodyParser())
  router.post("/api/add_event", middleware: CredentialsServer.credentials)
  router.post("/api/add_event", handler: EventApiController.handler)

  router.get("/", handler: LandingPageController.handler)
  router.get("/constitution", handler: ConstitutionController.handler)

  /// Custom event pages
  router.get("/events/2017/gamegig3000", handler: HackathonController.handler(hackathon: GameGig2017()))

  // MARK: Features in progress
  router.get("/beta/landing-update-feed", handler: LandingUpdateFeedController.handler)
  router.get("/workshops", handler: WorkshopsController.handler)
  router.get("/workshops/:workshopId", handler: WorkshopsController.workshopHandler)
  router.get("/workshops/update", middleware: CredentialsServer.credentials)
  router.get("/workshops/update", handler: WorkshopsController.workshopUpdateHandler)
  router.get("/workshops/validate/:workshopId", middleware: CredentialsServer.credentials)
  router.get("/workshops/validate/:workshopId", handler: WorkshopsController.workshopVerifyHandler)

  router.all("/", middleware: NotFoundMiddleware())
  router.error(ErrorRoutingMiddleware())

  // Enable http gzip compression globally
  // Compression is the last step in middleware chain, add all route handlers above
  router.all(middleware: Compression())

  return router
}

public func serveWebsite() {
  DatabaseUtils.prepareDatabase(withPreparations: DatabasePreparations.preparations)
  // Helium logger provides logging for Kitura processes
  HeliumLogger.use()
  // This speaks to Kitura's 'LoggerAPI' to set the default logger to HeliumLogger.
  // Kitura calls this API to log things

  Kitura.addHTTPServer(onPort: Config.listeningPort, with: getWebsiteRouter())
  Kitura.run() // This call never returns
}
