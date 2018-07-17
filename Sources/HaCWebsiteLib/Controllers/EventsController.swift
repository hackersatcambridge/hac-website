import Kitura
import HaCTML
import KituraNet
import LoggerAPI

struct EventsController {
  static var portalHandler: RouterHandler = { request, response, next in
    try response.send(
      AllEventsPage().node.render()
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

  static var deleteEventFormHandler: RouterHandler = { request, response, next in
    if let eventId = request.parameters["eventId"] {
      try response.send(
        DeleteEventPage(eventId: eventId).node.render()
      ).end() 
    } else {
      next()
    }
  }

  static var editEventPageHandler: RouterHandler = { request, response, next in
    if let eventId = request.parameters["eventId"] {
      guard let event = EventServer.getEvent(eventId: eventId) else {
        Log.info("API call tried to edit event that didn't exist")
        response.statusCode = HTTPStatusCode.badRequest
        try response.send("That event doesn't appear to exist\n").end()
        return
      }
      try response.send(
        EditEventPage(event: event).node.render()
      ).end() 
    } else {
      next()
    }
  }
}