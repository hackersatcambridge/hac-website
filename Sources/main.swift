import Foundation
import Kitura

import KituraStencil

import LoggerAPI
import HeliumLogger

// Create a new router
let router = Router()

// Heilium logger provides logging for Kitura processes
HeliumLogger.use()
// This speaks to Kitura's 'LoggerAPI' to set the default logger to HeliumLogger.
// Kitura calls this API to log things

// Set Stencil as the default template engine
router.setDefault(templateEngine: StencilTemplateEngine())

// Set up a static asset server at /static serving files from the /static/dist folder
router.all("/static", middleware: StaticFileServer(path: "./static/dist"))

// Handle HTTP GET requests to /
router.get("/") { request, response, next in
  defer {
    next()
  }
  do {
    var context: [String: Any] = [:]
    try response.render("home", context: context).end()
  } catch {
    Log.error("Failed to render template \(error)")
  }
}

router.get("/workshops") { request, response, next in
  defer {
    next()
  }
  do {
    var context: [String: Any] = [:]
    try response.render("workshops", context: context).end()
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
    var context: [String: Any] = [
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

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8090, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()
