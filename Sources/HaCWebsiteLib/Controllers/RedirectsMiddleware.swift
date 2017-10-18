import Kitura

private struct Redirect {
  let fromPath: String
  let toURL: String
}

private let defaultRedirects = [
  Redirect(
    fromPath: "/intro-to-programming",
    toURL: "https://github.com/hackersatcambridge/workshops/blob/master/workshops/introduction_to_programming/session_1/description.md"
  )
]

private func redirectRouter(_ redirects: [Redirect]) -> Router {
  let router = Router()

  for redirect in redirects {
    router.get(redirect.fromPath) { _, response, next in
      try response.redirect(redirect.toURL, status: .movedTemporarily).end()
      next()
    }
  }

  return router
}

private let router = redirectRouter(defaultRedirects)

struct RedirectsMiddleware: RouterMiddleware {
   func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws -> () {
     try router.handle(request: request, response: response, next: next)
  }
}
