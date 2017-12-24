import Kitura

struct WorkshopsController {

  static let upcomingWorkshopCards = [
    PostCard(
      title: "Intro to Python",
      category: .workshop,
      description: "Snakes are dangerous",
      backgroundColor: "#852503",
      imageURL: "/static/images/functions_frame.png"
    ),
    PostCard(
      title: "Intermediate Swift",
      category: .workshop,
      description: "Take your entire life to the next level",
      backgroundColor: "green",
      imageURL: "/static/images/workshop.jpg"
    )
  ]

  static let previousWorkshopCards = [
    PostCard(
      title: "Intermediate Swift",
      category: .workshop,
      description: "Take your entire life to the next level",
      backgroundColor: "#852503",
      imageURL: "/static/images/functions_frame.png"
    ),
    PostCard(
      title: "Binary Exploitation",
      category: .workshop,
      description: "Learn all the things.",
      backgroundColor: "green",
      imageURL: "/static/images/workshop.jpg"
    )
  ]

  static var handler: RouterHandler = { request, response, next in
    try response.send(
      WorkshopsIndexPage(
        upcomingWorkshops: upcomingWorkshopCards,
        previousWorkshops: previousWorkshopCards
      ).node.render()
    ).end()
  }

  static var workshopHandler: RouterHandler = { request, response, next in 
    try response.send(
      IndividualWorkshopPage().node.render()
    ).end()
  }

}
