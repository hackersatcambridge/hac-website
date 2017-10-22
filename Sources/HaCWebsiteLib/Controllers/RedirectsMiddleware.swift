import Kitura

struct RedirectsMiddleware: RouterMiddleware {
  let router = Router()

  init(redirects: [String: String]) {
    for (path, destinationURL) in redirects {
      router.get(path) { _, response, next in
        try response.redirect(destinationURL, status: .movedTemporarily).end()
        next()
      }
    }
  }

  func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws -> () {
     try router.handle(request: request, response: response, next: next)
  }
}
