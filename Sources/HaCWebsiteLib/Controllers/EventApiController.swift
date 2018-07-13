import Kitura
import KituraNet
import SwiftyJSON
import Foundation
import DotEnv
import LoggerAPI

struct EventApiController {
  static var addEventHandler: RouterHandler = { request, response, next in
    response.headers["Content-Type"] = "text/plain; charset=utf-8"
    guard let parsedBody = request.body else {
      next()
      response.statusCode = HTTPStatusCode.internalServerError
      Log.info("Unable to parse the body of the request")
      try response.send("Sorry - we weren't able to parse the body of the request\n").end()
      return
    }
    if case .json(let json) = parsedBody {
      do {
        if let eventId = json["eventId"] as? String {
          if EventServer.doesEventWithIdExist(eventId: eventId) {
            Log.info("Database event adding failed - Event with that ID exists")
            response.statusCode = HTTPStatusCode.badRequest
            try response.send("Database event adding failed - Event with that ID exists\n").end()
            return
          }
        }
        try saveEvent(json: json)
        Log.info("Succesfully added event to the database")
        try response.send("Successfully added your event to the database\n").end()
      }
      catch EventParsingError.missingParameters {
        Log.info("Database event adding failed - missing parameters")
        response.statusCode = HTTPStatusCode.badRequest
        try response.send("Sorry - looks like you didn't include all the necessary fields\n").end()
      } catch EventParsingError.invalidHypePeriod {
        Log.info("Database event adding failed - invalid hype period")
        response.statusCode = HTTPStatusCode.badRequest
        try response.send("Sorry - looks like the hype period was invalid\n").end()
      }
    } else {
      Log.info("Adding event to database failed for unkown reason")
      response.statusCode = HTTPStatusCode.badRequest
      try response.send("Please use JSON for post data\n").end()
    }
    next()
  }

  static var editEventHandler: RouterHandler = { request, response, next in
    response.headers["Content-Type"] = "text/plain; charset=utf-8"
    guard let parsedBody = request.body else {
      next()
      response.statusCode = HTTPStatusCode.internalServerError
      Log.info("Unable to parse the body of the request")
      try response.send("Sorry - we weren't able to parse the body of the request\n").end()
      return
    }
    if case .json(let json) = parsedBody {
      do {
        guard let id = request.parameters["eventId"] else {
          throw EventParsingError.missingParameters
        }
        guard let event = EventServer.getEvent(eventId: id) else {
          throw EventParsingError.noSuchEvent
        }
        let updatedEvent = try updateNecessaryFields(event: event, updates: json)
        try updatedEvent.save()
      } catch EventParsingError.missingParameters {
        Log.info("Updating event in database failed due to missing parameters in api call")
        response.statusCode = HTTPStatusCode.badRequest
        try response.send("There were missing parameters in your api call. Please consult the API documentation. \n").end()
        return
      } catch EventParsingError.noSuchEvent {
        Log.info("Updating event in database failed due to the event not existing")
        response.statusCode = HTTPStatusCode.badRequest
        try response.send("It appears there is no such event with that id.\n").end()
        return
      } catch {
        Log.info("Updating event in database failed due to unknown reason")
        response.statusCode = HTTPStatusCode.badRequest
        try response.send("Could not update event for unknown reason. \n").end()
        return
      }
      Log.info("Event updated in database sucessfully")
      response.statusCode = HTTPStatusCode.badRequest
      try response.send("The event has been updated sucessfully.\n").end()
      return
    } else {
      Log.info("Editing event in database failed for unkown reason")
      response.statusCode = HTTPStatusCode.badRequest
      try response.send("Please use JSON for post data\n").end()
      return
    }
    next()
  }

  static var deleteEventHandler: RouterHandler = { request, response, next in
    response.headers["Content-Type"] = "text/plain; charset=utf-8"
    guard let parsedBody = request.body else {
      next()
      response.statusCode = HTTPStatusCode.internalServerError
      Log.info("Unable to parse the body of the request")
      try response.send("Sorry - we weren't able to parse the body of the request\n").end()
      return
    }
    if case .json(let json) = parsedBody {
      do {
        guard let id = json["eventId"] as? String else {
          throw EventParsingError.missingParameters
        }
        guard let event = EventServer.getEvent(eventId: id) else {
          throw EventParsingError.noSuchEvent
        }
        try event.delete()
      } catch EventParsingError.missingParameters {
        Log.info("Deleting event in database failed due to missing eventId parameter")
        response.statusCode = HTTPStatusCode.badRequest
        try response.send("Deleting event in database failed due to missing eventId parameter.\n").end()
      } catch EventParsingError.noSuchEvent {
        Log.info("Deleting event in database failed due to the event not existing")
        response.statusCode = HTTPStatusCode.badRequest
        try response.send("It appears there is no such event with that id.\n").end()
      } catch {
        Log.info("Deleting event in database failed due to unknown reason")
        response.statusCode = HTTPStatusCode.badRequest
        try response.send("Could not delete event for unknown reason. \n").end()
      }
      Log.info("Event deleted from database sucessfully")
      response.statusCode = HTTPStatusCode.badRequest
      try response.send("The event has been deleted sucessfully.\n").end()
    } else {
      Log.info("Deleting event in database failed for unkown reason")
      response.statusCode = HTTPStatusCode.badRequest
      try response.send("Please use JSON for post data\n").end()
    }
    next()
  }

  private static func saveEvent(json: [String : Any]) throws {
    let event = try parseEvent(json: json)
    try event.save()
  }

  public static func parseEvent(json : [String : Any]) throws -> GeneralEvent {
    guard let eventId = json["eventId"] as? String,
    let title = json["title"] as? String,
    let startDate = Date.from(string: json["startDate"] as? String),
    let endDate = Date.from(string: json["endDate"] as? String),
    let tagLine = json["tagLine"] as? String,
    let color = json["color"] as? String,
    let hypeStartDate = Date.from(string: json["hypeStartDate"] as? String),
    let hypeEndDate = Date.from(string: json["hypeEndDate"] as? String),
    let tags = getOptionalTags(json: json),
    let markdownDescription = json["markdownDescription"] as? String else {
      throw EventParsingError.missingParameters
    }

    // Make sure the event itself falls within the hype period
    // If it doesn't, we throw an invalidHypePeriod exception
    if !((hypeStartDate <= startDate) &&
       (startDate <= hypeEndDate) &&
       (hypeStartDate <= endDate) &&
       (endDate <= hypeEndDate)) {
         throw EventParsingError.invalidHypePeriod
    }

    let location = getOptionalLocation(json: json)
    let time = DateInterval(start: startDate, end: endDate)
    let hypePeriod = DateInterval(start: hypeStartDate, end: hypeEndDate)
    let eventDescription = Markdown(markdownDescription)

    //Optional parameters
    let websiteURL = json["websiteURL"] as? String
    let imageURL = json["imageURL"] as? String
    let facebookEventID = json["facebookEventID"] as? String

    return GeneralEvent(eventId: eventId, title: title, time: time, tagLine: tagLine, color: color, hypePeriod: hypePeriod,
      tags: tags, description: eventDescription, websiteURL: websiteURL, imageURL: imageURL, location: location,
      facebookEventID: facebookEventID)
  }

  private static func getOptionalLocation(json: [String : Any]) -> Location? {
    var long : Double? = nil
    var lat : Double? = nil
    if let latInt = json["latitude"] as? Int { lat = Double(latInt) }
    if let longInt = json["longitude"] as? Int { long = Double(longInt) }
    if let latDouble = json["latitude"] as? Double { lat = latDouble }
    if let longDouble = json["longitude"] as? Double { long = longDouble }

    let venue = json["venue"] as? String
    let address = json["address"] as? String

    if let longitude = long, let latitude = lat {
      return Location(latitude: latitude, longitude: longitude, address: address, venue: venue) 
    }
    return nil
  }

  private static func getOptionalTags(json: [String : Any]) -> [String]? {
    //Returns an array of tags or nil if the array is empty/doesn't exist in the json
    guard let tagsArray = json["tags"] as? [String] else {
      return nil
    }
    if tagsArray == [] || tagsArray[0] == "" {
      return nil
    }
    return tagsArray
  }

  private static func updateNecessaryFields(event: GeneralEvent, updates json: [String : Any]) throws -> GeneralEvent {
    let fieldsToUpdate = json.keys

    if fieldsToUpdate.contains("eventId") {
      if let newEventId = json["eventId"] as? String {
        event.eventId = newEventId
      } else {
        throw EventParsingError.invalidUpdateValue
      }
    }
    if fieldsToUpdate.contains("title") {
      if let newTitle = json["title"] as? String {
        event.title = newTitle
      } else {
        throw EventParsingError.invalidUpdateValue
      }
    }
    if fieldsToUpdate.contains("tagLine") {
      if let newTagLine = json["tagLine"] as? String {
        event.tagLine = newTagLine
      } else {
        throw EventParsingError.invalidUpdateValue
      }
    }
    if fieldsToUpdate.contains("color") {
      if let newColor = json["color"] as? String {
        event.color = newColor
      } else {
        throw EventParsingError.invalidUpdateValue
      }
    }
    if fieldsToUpdate.contains("websiteURL") {
      if let newURL = json["websiteURL"] as? String {
        event.websiteURL = newURL
      } else {
        throw EventParsingError.invalidUpdateValue
      }
    }
    if fieldsToUpdate.contains("imageURL") {
      if let newURL = json["imageURL"] as? String {
        event.imageURL = newURL
      } else {
        throw EventParsingError.invalidUpdateValue
      }
    }
    if fieldsToUpdate.contains("markdownDescription") {
      if let newMarkdownDescription = json["markdownDescription"] as? String {
        event.eventDescription = Markdown(newMarkdownDescription)
      } else {
        throw EventParsingError.invalidUpdateValue
      }
    }
    if fieldsToUpdate.contains("facebookEventID") {
      if let newFacebookId = json["facebookEventID"] as? String {
        event.facebookEventID = newFacebookId
      } else {
        throw EventParsingError.invalidUpdateValue
      }
    }
    if fieldsToUpdate.contains("startDate") {
      if let newStartDate = Date.from(string: json["startDate"] as? String) {
        let endDate = event.time.end
        event.time = DateInterval(start: newStartDate, end: endDate)
      } else {
        throw EventParsingError.invalidUpdateValue
      }
    }
    if fieldsToUpdate.contains("endDate") {
      if let newEndDate = Date.from(string: json["endDate"] as? String) {
        let startDate = event.time.start
        event.time = DateInterval(start: startDate, end: newEndDate)
      } else {
        throw EventParsingError.invalidUpdateValue
      }
    }
    if fieldsToUpdate.contains("hypeStartDate") {
      if let newHypeStartDate = Date.from(string: json["hypeStartDate"] as? String) {
        let hypeEndDate = event.time.end
        event.hypePeriod = DateInterval(start: newHypeStartDate, end: hypeEndDate)
      } else {
        throw EventParsingError.invalidUpdateValue
      }
    }
    if fieldsToUpdate.contains("hypeEndDate") {
      if let newHypeEndDate = Date.from(string: json["hypeEndDate"] as? String) {
        let hypeStartDate = event.time.start
        event.hypePeriod = DateInterval(start: hypeStartDate, end: newHypeEndDate)
      } else {
        throw EventParsingError.invalidUpdateValue
      }
    }
    if let newTags = getOptionalTags(json: json) {
      event.tags = newTags
    }
    if let newLocation = getOptionalLocation(json: json) {
      event.location = newLocation
    }
    return event
  }
}

enum EventParsingError: Swift.Error {
  case missingParameters
  case invalidHypePeriod
  case noSuchEvent
  case invalidUpdateValue
}
