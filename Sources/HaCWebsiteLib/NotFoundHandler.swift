import Foundation
import Kitura

public class NotFoundHandler: RouterMiddleware {

  public func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) {
    defer {
      next()
    }
    if response.statusCode != .OK {
      try? response.send(
        NotFound().node.render()
      ).end()
    }
  }
}