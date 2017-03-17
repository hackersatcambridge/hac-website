import Foundation
import Kitura

import KituraStencil

import LoggerAPI
import HeliumLogger

public func serveWebsite() {
  let router = Router()

  // Heilium logger provides logging for Kitura processes
  HeliumLogger.use()
  // This speaks to Kitura's 'LoggerAPI' to set the default logger to HeliumLogger.
  // Kitura calls this API to log things

  router.setDefault(templateEngine: StencilTemplateEngine())
  router.all("/static", middleware: StaticFileServer(path: "./static/dist"))

  router.get("/") { request, response, next in
    defer {
      next()
    }
    do {
      try response.render("home", context: [:]).end()
    } catch {
      Log.error("Failed to render template \(error)")
    }
  }

  router.get("/workshops") { request, response, next in
    defer {
      next()
    }
    do {
      try response.render("workshops", context: [:]).end()
    } catch {
      Log.error("Failed to render template \(error)")
    }
  }

  struct Event {
    let title: String
    let date: Date
    let description: String
    let prerequisites: String
  }

  router.get("/events") { request, response, next in
    defer {
      next()
    }
    do {
      let context: [String: Any] = [
        "events": [
          Event(title: "Introduction to RxJava", date: Date(), description: "This will be great", prerequisites: "Be good"),
          Event(title: "Charitech", date: Date(), description: "This will be great too", prerequisites: "Be better"),
        ]
      ]
      try response.render("events", context: context).end()
    } catch {
      Log.error("Failed to render template \(error)")
    }
  }

  Kitura.addHTTPServer(onPort: Config.listeningPort, with: router)

  // Start the Kitura runloop (this call never returns)
  Kitura.run()
}
