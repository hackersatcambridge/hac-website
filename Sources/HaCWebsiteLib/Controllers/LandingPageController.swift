import Foundation
import Kitura
import HaCTML
import LoggerAPI
import HeliumLogger
import DotEnv
import SwiftyJSON

struct LandingPageController {
  static let updates = [
    PostCard(
      title: "Conquering Linux",
      category: .workshop,
      description: "Be great at computers, not because you can, but because you dream.",
      backgroundColor: "purple",
      imageURL: "/static/images/workshop.jpg"
    ),
    PostCard(
      title: "Partial Recursive Functions 1: Functions",
      category: .video,
      description: "Learn all the things.",
      backgroundColor: "#852503",
      imageURL: "/static/images/functions_frame.png"
    ),
    PostCard(
      title: "Intermediate Git",
      category: .workshop,
      description: "Merge conflicts? Rescuing yourself from a hairy rebase? No sweat.",
      backgroundColor: "black",
      imageURL: "/static/images/intermediate_git.png"
    ),
    PostCard(
      title: "Game Gig 2017",
      category: .hackathon,
      description: "Are you game?",
      backgroundColor: "#ECA414",
      imageURL: nil
    )
  ]

  static var handler: RouterHandler = { request, response, next in
    try response.send(
      LandingPage(updates: updates).node.render()
    ).end()
  }
}
