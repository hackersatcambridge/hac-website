import Kitura

struct WorkshopsController {
  static let handler: RouterHandler = { _, response, next in
    try response.send(
      UI.Pages.workshops(workshops: WorkshopManager.workshops).render()
    ).end()
    next()
  }
}
