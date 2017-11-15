import Kitura
import KituraNet
import SwiftyJSON
import Foundation
import DotEnv

struct EventApiController {
  static var handler: RouterHandler = { request, response, next in
    response.headers["Content-Type"] = "text/plain; charset=utf-8"
    guard let parsedBody = request.body else {
      next()
      response.statusCode = HTTPStatusCode.internalServerError
      try response.send("Sorry - we weren't able to parse the body of the request\n").end()
      return
    }
    if case .json(let json) = parsedBody {
      do {
        try verifyAndSaveEvent(json: json)
        try response.send("Successfully added your event to the database\n").end()
      }
      catch EventParsingError.incorrectPassword {
        response.statusCode = HTTPStatusCode.unauthorized
        try response.send("Sorry - your password is incorrect\n").end()
      } catch EventParsingError.missingParameters {
        response.statusCode = HTTPStatusCode.badRequest
        try response.send("Sorry - looks like you didn't include all the necessary fields\n").end()
      } 
    } else {
      response.statusCode = HTTPStatusCode.badRequest
      try response.send("Please use JSON for post data\n").end()
    }
    next()
  }

  static func verifyAndSaveEvent(json: JSON) throws {
    if !isCorrectPassword(json: json) {
      throw EventParsingError.incorrectPassword
    }
    let event = try parseEvent(json: json)
    try event.save()
  }

  static func isCorrectPassword(json: JSON) -> Bool {
    let password = json["password"].stringValue
    guard let realPassword = DotEnv.get("API_PASSWORD") else {
      return false
    }
    return password == realPassword
  }

  static func parseEvent(json : JSON) throws -> GeneralEvent {
    guard let title = json["title"].string,
    let startDate = json["startDate"].dateTime,
    let endDate = json["endDate"].dateTime,
    let tagLine = json["tagLine"].string,
    let color = json["color"].string,
    let hypeStartDate = json["hypeStartDate"].dateTime,
    let hypeEndDate = json["hypeEndDate"].dateTime,
    let tags = getOptionalTags(json: json),
    let markdownDescription = json["markdownDescription"].string else {
      throw EventParsingError.missingParameters
    }

    let location = getOptionalLocation(json: json) 
    let time = DateInterval(start: startDate, end: endDate)
    let hypePeriod = DateInterval(start: hypeStartDate, end: hypeEndDate)
    let eventDescription = Markdown(markdownDescription)

    //Optional parameters
    let websiteURL = json["websiteURL"].string
    let imageURL = json["imageURL"].string
    let facebookEventID = json["facebookEventID"].string

    return GeneralEvent(title: title, time: time, tagLine: tagLine, color: color, hypePeriod: hypePeriod,
      tags: tags, description: eventDescription, websiteURL: websiteURL, imageURL: imageURL, location: location,
      facebookEventID: facebookEventID)
  }

  static func getOptionalLocation(json: JSON) -> Location? {
    guard let latitude = json["latitude"].double,
    let longitude = json["longitude"].double else {
      return nil
    }
    let venue = json["venue"].stringValue
    let address = json["address"].stringValue
    return Location(latitude: latitude, longitude: longitude, address: address, venue: venue)
  }

  static func getOptionalTags(json: JSON) -> [String]? {
    //Returns an array of tags or nil if the array is empty/doesn't exist in the json
    let tagsJSON = json["tags"].arrayValue
    let tagsArray = tagsJSON.map({$0.stringValue})
    if tagsJSON == [] || tagsArray[0] == "" {
      return nil
    }
    return tagsArray
  }
}

enum EventParsingError: Swift.Error {
  case missingParameters
  case incorrectPassword
}
