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
        try getEventFromJSON(src: json).save()
        Log.info("Succesfully added event to the database")
        response.send("Successfully added your event to the database\n")
      } catch EventParsingError.missingParameters {
        Log.info("Database event adding failed - missing parameters")
        response.statusCode = HTTPStatusCode.badRequest
        response.send("Sorry - looks like you didn't include all the necessary fields\n")
      } catch EventParsingError.invalidHypePeriod {
        Log.info("Database event adding failed - invalid hype period")
        response.statusCode = HTTPStatusCode.badRequest
        response.send("Sorry - looks like the hype period was invalid\n")
      }
    } else {
      Log.info("Adding event to database failed for unkown reason")
      response.statusCode = HTTPStatusCode.badRequest
      response.send("Please use JSON for post data\n")
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
        Log.info("Event updated in database sucessfully")
        response.send("The event has been updated sucessfully.\n")
      } catch EventParsingError.missingParameters {
        Log.info("Updating event in database failed due to missing parameters in api call")
        response.statusCode = HTTPStatusCode.badRequest
        response.send("There were missing parameters in your api call. Please consult the API documentation. \n")
      } catch EventParsingError.noSuchEvent {
        Log.info("Updating event in database failed due to the event not existing")
        response.statusCode = HTTPStatusCode.badRequest
        response.send("It appears there is no such event with that id.\n")
      } catch {
        Log.info("Updating event in database failed due to unknown reason")
        response.statusCode = HTTPStatusCode.badRequest
        response.send("Could not update event for unknown reason. \n")
      }
    } else {
      Log.info("Editing event in database failed for unkown reason")
      response.statusCode = HTTPStatusCode.badRequest
      response.send("Please use JSON for post data\n")
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
        Log.info("Event deleted from database sucessfully")
        response.send("The event has been deleted sucessfully.\n")
      } catch EventParsingError.missingParameters {
        Log.info("Deleting event in database failed due to missing eventId parameter")
        response.statusCode = HTTPStatusCode.badRequest
        response.send("Deleting event in database failed due to missing eventId parameter.\n")
      } catch EventParsingError.noSuchEvent {
        Log.info("Deleting event in database failed due to the event not existing")
        response.statusCode = HTTPStatusCode.badRequest
        response.send("It appears there is no such event with that id.\n")
      } catch {
        Log.info("Deleting event in database failed due to unknown reason")
        response.statusCode = HTTPStatusCode.badRequest
        response.send("Could not delete event for unknown reason. \n")
      }
    } else {
      Log.info("Deleting event in database failed for unkown reason")
      response.statusCode = HTTPStatusCode.badRequest
      response.send("Please use JSON for post data\n")
    }
    next()
  }

  /*
  Generate a GeneralEvent object from a JSON object containing ALL the necessary fields.
  */
  public static func getEventFromJSON(src json: [String : Any]) throws -> GeneralEvent {
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
    if !((hypeStartDate <= startDate) && (startDate <= endDate) && (endDate <= hypeEndDate)) {
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

    return GeneralEvent(
      eventId: eventId,
      title: title, 
      time: time, 
      tagLine: tagLine, 
      color: color, 
      hypePeriod: hypePeriod,
      tags: tags, 
      description: eventDescription, 
      websiteURL: websiteURL, 
      imageURL: imageURL, 
      location: location,
      facebookEventID: facebookEventID
    )
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
    event.eventId = try getLatestFieldString(originalValue: event.eventId, json: json, fieldName: "eventId")
    event.title = try getLatestFieldString(originalValue: event.title, json: json, fieldName: "title")
    event.tagLine = try getLatestFieldString(originalValue: event.tagLine, json: json, fieldName: "tagLine")
    event.color = try getLatestFieldString(originalValue: event.color, json: json, fieldName: "color")
    event.websiteURL = try getLatestFieldStringOpt(originalValue: event.websiteURL, json: json, fieldName: "websiteURL")
    event.imageURL = try getLatestFieldStringOpt(originalValue: event.imageURL, json: json, fieldName: "imageURL")
    event.eventDescription = Markdown(try getLatestFieldString(originalValue: event.eventDescription.raw, json: json, fieldName: "markdownDescription"))
    event.facebookEventID = try getLatestFieldStringOpt(originalValue: event.facebookEventID, json: json, fieldName: "facebookEventID")

    //Check for new times in json
    
    let startDate = getLatestFieldDate(originalValue: event.time.start, json: json, fieldName: "startDate")
    let endDate = getLatestFieldDate(originalValue: event.time.end, json: json, fieldName: "endDate")
    let hypeStartDate = getLatestFieldDate(originalValue: event.hypePeriod.start, json: json, fieldName: "hypeStartDate")
    let hypeEndDate = getLatestFieldDate(originalValue: event.hypePeriod.end, json: json, fieldName: "hypeEndDate")
    
    if !((hypeStartDate <= startDate) &&
      (startDate <= endDate) &&
      (endDate <= hypeEndDate)) {
        throw EventParsingError.invalidUpdateValue
    }
    //Update DateIntervals in event
    event.time = DateInterval(start: startDate, end: endDate)
    event.hypePeriod = DateInterval(start: hypeStartDate, end: hypeEndDate)

    if let newTags = getOptionalTags(json: json) {
      event.tags = newTags
    }
    if let newLocation = getOptionalLocation(json: json) {
      event.location = newLocation
    }
    return event
  }

  /*
  Scan through a json and return either 
  - the String for a given key if it exists in the json, or
  - the old String of the field if the key doesn't exist in the json
  */
  private static func getLatestFieldString(originalValue: String, json: [String: Any], fieldName: String) throws -> String {
    if json.keys.contains(fieldName) {
      if let newValue = json[fieldName] as? String {
        return newValue
      } else {
        throw EventParsingError.invalidUpdateValue
      }
    } else {
      return originalValue
    }
  }

  private static func getLatestFieldStringOpt(originalValue: String?, json: [String: Any], fieldName: String) throws -> String? {
    if json.keys.contains(fieldName) {
      if let newValue = json[fieldName] as? String {
        return newValue
      } else {
        throw EventParsingError.invalidUpdateValue
      }
    } else {
      return originalValue
    }
  }

  /*
  Scan through a json and return either 
  - the Date for a given key if it exists in the json, or
  - the old Date of the field if the key doesn't exist in the json
  */
  private static func getLatestFieldDate(originalValue: Date, json: [String: Any], fieldName: String) -> Date {
    if json.keys.contains(fieldName) {
      if let newValue = Date.from(string: json[fieldName] as? String) {
        return newValue
      }
    }
    return originalValue
  }
}

enum EventParsingError: Swift.Error {
  case missingParameters
  case invalidHypePeriod
  case noSuchEvent
  case invalidUpdateValue
}
