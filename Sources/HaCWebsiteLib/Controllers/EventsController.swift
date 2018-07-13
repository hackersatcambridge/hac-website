import Kitura
import HaCTML

struct EventsController {
    static var portalHandler: RouterHandler = { request, response, next in
    try response.send(
      EventsPage().node.render()
    ).end()
  }
  
  static var individualEventHandler: RouterHandler = { request, response, next in
    if let eventId = request.parameters["eventId"],
      let event = EventServer.getEvent(eventId: eventId) {
        try response.send(
          IndividualEventPage(event: event).node.render()
        ).end() 
    } else {
      next()
    }
  }

  static var addEventFormHandler: RouterHandler = { request, response, next in
    try response.send(
      AddEventForm().node.render()
    ).end() 
  }
}