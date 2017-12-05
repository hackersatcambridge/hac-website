import Foundation
import Kitura
import HaCTML
import LoggerAPI
import HeliumLogger
import DotEnv
import SwiftyJSON

struct HackathonController {
  static func handler(hackathon: Hackathon) -> RouterHandler {
    return { request, response, next in
      try response.send(
        hackathon.node.render()
      ).end()
    }
  }
}
