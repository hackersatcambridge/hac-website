import Foundation
import Kitura

public class ErrorRoutingMiddleware: RouterMiddleware {

  public func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) {
    defer {
      next()
    }
    if response.statusCode != .OK {
      try? response.send(
        ServerError().node.render()
      ).end()
    }
  }
}