import Kitura
import KituraNet
import SwiftyJSON
import Foundation
import DotEnv
import LoggerAPI

struct EventApiController {
  static var handler: RouterHandler = { request, response, next in
    response.headers["Content-Type"] = "text/plain; charset=utf-8"
    guard let parsedBody = request.body else {
      next()
      response.statusCode = HTTPStatusCode.internalServerError
      // TODO: Log info about why?
      Log.info("Unable to parse the body of the request")
      try response.send("Sorry - we weren't able to parse the body of the request\n").end()
      return
    }
    if case .json(let json) = parsedBody {
      do {
        try saveEvent(json: json)
        // TODO: Log info about which fields were missing?
        Log.info("Succesfully added event to the database")
        try response.send("Successfully added your event to the database\n").end()
      }
      catch EventParsingError.missingParameters {
        // TODO: Log info about which fields were missing?
        Log.info("Database event adding failed - missing parameters")
        response.statusCode = HTTPStatusCode.badRequest
        try response.send("Sorry - looks like you didn't include all the necessary fields\n").end()
      }
    } else {
      // TODO: Log info about what went wrong?
      Log.info("Adding event to database failed for unkown reason")
      response.statusCode = HTTPStatusCode.badRequest
      try response.send("Please use JSON for post data\n").end()
    }
    next()
  }

  private static func saveEvent(json: [String : Any]) throws {
    let event = try parseEvent(json: json)
    try event.save()
  }

  private static func parseEvent(json : [String : Any]) throws -> GeneralEvent {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzz"

    guard let title = json["title"] as? String,
    let startDateString = json["startDate"] as? String,
    let endDateString = json["endDate"] as? String,
    let tagLine = json["tagLine"] as? String,
    let color = json["color"] as? String,
    let hypeStartDateString = json["hypeStartDate"] as? String,
    let hypeEndDateString = json["hypeEndDate"] as? String,
    let startDate = dateFormatter.date(from: startDateString),
    let endDate = dateFormatter.date(from: endDateString),
    let hypeStartDate = dateFormatter.date(from: hypeStartDateString),
    let hypeEndDate = dateFormatter.date(from: hypeEndDateString),
    let tags = getOptionalTags(json: json),
    let markdownDescription = json["markdownDescription"] as? String else {
      throw EventParsingError.missingParameters
    }

    let location = getOptionalLocation(json: json)
    let time = DateInterval(start: startDate, end: endDate)
    let hypePeriod = DateInterval(start: hypeStartDate, end: hypeEndDate)
    let eventDescription = Markdown(markdownDescription)

    //Optional parameters
    let websiteURL = json["websiteURL"] as? String
    let imageURL = json["imageURL"] as? String
    let facebookEventID = json["facebookEventID"] as? String

    return GeneralEvent(title: title, time: time, tagLine: tagLine, color: color, hypePeriod: hypePeriod,
      tags: tags, description: eventDescription, websiteURL: websiteURL, imageURL: imageURL, location: location,
      facebookEventID: facebookEventID)
  }

  private static func getOptionalLocation(json: [String : Any]) -> Location? {
    guard let latitude = json["latitude"] as? Int,
    let longitude = json["longitude"] as? Int else {
      return nil
    }
    let venue = json["venue"] as? String
    let address = json["address"] as? String
    return Location(latitude: Double(latitude), longitude: Double(longitude),
      address: address, venue: venue)
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
}

enum EventParsingError: Swift.Error {
  case missingParameters
}
