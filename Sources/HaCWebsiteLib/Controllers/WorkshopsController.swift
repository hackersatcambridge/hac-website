import Kitura

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
      let workshop = WorkshopManager.workshops["workshop-\(workshopId)"] {
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

}
