import Foundation
import Kitura
import HaCTML
import LoggerAPI
import HeliumLogger
import DotEnv
import SwiftyJSON
import LoggerAPI

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
    let fromDate : Date = Date.from(string: request.queryParameters["fromDate"]) ?? Date()
    let toDate : Date = Date.from(string: request.queryParameters["toDate"]) ?? Date()

    let eventPostCards : [PostCard] = EventServer.getEvents(from: fromDate, to: toDate).flatMap{ event in
      event.postCardRepresentation
    }
    let updates = eventPostCards + videos
    try response.send(
      LandingUpdateFeed(updates: updates).node.render()
    ).end()
  }
}
