import Kitura

struct GitHubWebhookController {
  static func handler(updater: @escaping () throws -> Void) -> RouterHandler {
    return { _, _, _ in
      try updater()
    }
  }
}
