import Kitura
import HaCTML

struct WorkshopsController {

  static var handler: RouterHandler = { request, response, next in
    try response.send(
      WorkshopsIndexPage(
        allWorkshops: Array(WorkshopManager.workshops.values)
          .sorted { $0.title < $1.title }
          .filter { $0.workshopId != "example" }
      ).node.render()
    ).end()
  }

  static var workshopHandler: RouterHandler = { request, response, next in
    if let workshopId = request.parameters["workshopId"],
      let workshop = WorkshopManager.workshops[workshopId] {
        try response.send(
          IndividualWorkshopPage(workshop: workshop).node.render()
        ).end()
    } else {
      next()
    }
  }

  static var workshopUpdateHandler: RouterHandler = { request, response, next in
    WorkshopManager.update()
    try response.send(
      "Workshops updated!"
    ).end()
  }

  static var workshopVerifyHandler: RouterHandler = { request, response, next in
    if let workshopId = request.parameters["workshopId"] {
      let workshopURL = "https://github.com/hackersatcambridge/workshop-\(workshopId)"
      // Run the parser
      // Spit out the errors, or the workshop page if no errors
      let repoUtil = GitUtil(
        remoteRepoURL: workshopURL,
        directoryName: "workshop-\(workshopId)"
      )
      print("Updating repo...")
      repoUtil.update()
      print("Finished updating")

      let errorNode: Nodeable?
      let pageNode: Nodeable?

      do {
        let workshop = try Workshop(localPath: repoUtil.localRepoPath, headCommitSha: repoUtil.getHeadCommitSha())

        // MARK: Add warnings that probably indicate mistakes but are not validation errors
        var warnings: [String] = []
        if workshop.title == "Sample Workshop" { warnings.append("Title has not been set") }
        if workshop.contributors.isEmpty { warnings.append("Contributors have not been listed") }

        if warnings.isEmpty {
          errorNode = El.Div[
            Attr.className => "FlashMessage FlashMessage--positive"
          ].containing(
            "Valid workshop repo!"
          )
        } else {
          errorNode = El.Div[
            Attr.className => "FlashMessage FlashMessage--minorNegative"
          ].containing(
            El.Ul.containing(
              warnings.map {
                El.Li.containing("warning: \($0)")
              }
            )
          )
        }

        pageNode = IndividualWorkshopPage(workshop: workshop)

      } catch {
        errorNode = El.Div[Attr.className => "FlashMessage FlashMessage--negative"].containing("error: \(error)")
        pageNode = nil
      }
      try response.send(
        Page(
          title: "Workshop Validator: \(workshopId)",
          content: Fragment([
            errorNode,
            pageNode
          ])
        ).render()
      ).end()
    } else {
      next()
    }
  }

}
