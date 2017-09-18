import Foundation
import Kitura
import HaCTML
import LoggerAPI
import HeliumLogger
import DotEnv
import SwiftyJSON

struct LandingPageController {

  static let eventPostCards : [PostCard] = EventServer.getEvents().flatMap{ event in 
    (event as? PostCardRepresentable)?.postCardRepresentation
  }

  static let videos = [
    PostCard(
      title: "Partial Recursive Functions 1: Functions",
      category: .video,
      description: "Learn all the things.",
      backgroundColor: "#852503",
      imageURL: "/static/images/functions_frame.png"
    )
  ]

  static let updates = eventPostCards + videos

  static var handler: RouterHandler = { request, response, next in
    defer {
      next()
    }
    do {
      try response.send(
        LandingPage(updates: updates).node.render()
      ).end()
    } catch {
      Log.error("Socket error occured")
    }
  }
}