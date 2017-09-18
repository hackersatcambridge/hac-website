import Foundation
import Kitura
import HaCTML
import LoggerAPI
import HeliumLogger
import DotEnv
import SwiftyJSON

struct LandingPageController {

  static let eventPostCards : [PostCard] = EventServer.getEvents().flatMap{ $0.toPostCard() }

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

extension Event {
  func toPostCard() -> PostCard? {
    switch self {
      case is WorkshopEvent:
        return PostCard(
          title: self.title,
          category: .workshop,
          description: self.eventDescription,
          backgroundColor: self.color, //TODO
          imageURL: self.imageURL
        )
      case is HackathonEvent:
        return PostCard(
          title: self.title,
          category: .hackathon,
          description: self.eventDescription,
          backgroundColor: self.color, //TODO
          imageURL: self.imageURL
        )
      default:
        return nil
    }
    
  }
}