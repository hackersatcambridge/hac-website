import Kitura
import HaCTML

struct EventsController {
    static var handler: RouterHandler = { request, response, next in
    try response.send(
      EventsPage().node.render()
    ).end()
  }
}