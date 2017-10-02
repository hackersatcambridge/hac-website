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

  router.all("/static", middleware: StaticFileServer(path: "./static/dist"))

  router.get("/", handler: LandingPageController.handler)

  router.get("/workshops") { request, response, next in
    defer {
      next()
    }
    do {
      try response.send(
        UI.Pages.workshops(workshops: WorkshopManager.workshops).render()
      )
      .end()
    } catch {
      Log.error("Failed to render template \(error)")
    }
  }

  /// Intended for use by GitHub webhooks
  router.post("/api/refresh_workshops") { request, response, _ in
    try! WorkshopManager.update()
  }

  return router
}

public func serveWebsite() {
  testDatabase()
  // Helium logger provides logging for Kitura processes
  HeliumLogger.use()
  // This speaks to Kitura's 'LoggerAPI' to set the default logger to HeliumLogger.
  // Kitura calls this API to log things

  Kitura.addHTTPServer(onPort: Config.listeningPort, with: getWebsiteRouter())
  Kitura.run() // This call never returns
}
