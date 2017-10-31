import Kitura

struct ConstitutionController {
    static var handler: RouterHandler = { request, response, next in
    try response.send(
      Constitution(mdText: ConstitutionManager.mdConstitution).node.render()
    ).end()
  }
}
