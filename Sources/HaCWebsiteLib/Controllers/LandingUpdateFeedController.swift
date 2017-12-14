import Foundation
import Kitura
import HaCTML
import LoggerAPI
import HeliumLogger
import DotEnv
import SwiftyJSON

struct LandingUpdateFeedController {

  static let videos = [
    PostCard(
      title: "Partial Recursive Functions 1: Functions",
      category: .video,
      description: "Learn all the things.",
      backgroundColor: "#852503",
      imageURL: Assets.publicPath("/images/functions_frame.png")
    ),
    PostCard(
      title: "TCP Throughput",
      category: .video,
      description: "Learn all the things.",
      backgroundColor: "green",
      imageURL: Assets.publicPath("/images/workshop.jpg")
    )
  ]

  static var handler: RouterHandler = { request, response, next in
    let eventPostCards : [PostCard] = EventServer.getCurrentEvents().flatMap{ event in 
      event.postCardRepresentation
    }
    let updates = eventPostCards + videos
    try response.send(
      LandingUpdateFeed(updates: updates).node.render()
    ).end()
  }
}
