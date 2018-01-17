import Kitura

struct WorkshopsController {

  static var handler: RouterHandler = { request, response, next in
    try response.send(
      WorkshopsIndexPage(
        allWorkshops: Array(NewWorkshopManager.workshops.values).sorted { $0.title < $1.title }
      ).node.render()
    ).end()
  }

  static var workshopHandler: RouterHandler = { request, response, next in 
    if let workshopId = request.parameters["workshopId"],
      let workshop = NewWorkshopManager.workshops["workshop-\(workshopId)"] {
        try response.send(
          IndividualWorkshopPage(workshop: workshop).node.render()
        ).end()
    } else {
      next()
    }
  }

}
