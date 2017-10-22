import Kitura

struct GitHubWebhookController {
  static var handler: RouterHandler = { _, _, _ in
    try WorkshopManager.update()
  }
}