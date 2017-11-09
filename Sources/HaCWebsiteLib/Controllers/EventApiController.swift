import Kitura
import KituraNet
import SwiftyJSON
import Foundation

struct EventApiController {
  static var handler: RouterHandler = { request, response, next in
    response.headers["Content-Type"] = "text/plain; charset=utf-8"
    guard let parsedBody = request.body else {
      next()
      try response.send(status: HTTPStatusCode.internalServerError).end()
			return
    }
    switch parsedBody {
			case .json(let json):
				let event = parseEvent(json: json)
				try event.save()
				response.send("Successfully added your event to the database\n")
			default:
				try response.send(status: HTTPStatusCode.badRequest).end()
			break
    }
    next()
  }

	static func parseEvent(json : JSON) -> GeneralEvent {
		let title = json["title"].stringValue
		let startDate = json["startDate"].dateTime
		let endDate = json["endDate"].dateTime
		let tagLine = json["tagLine"].stringValue
		let color = json["color"].stringValue
		let hypeStartDate = json["hypeStartDate"].dateTime
		let hypeEndDate = json["hypeEndDate"].dateTime
		let tags = json["tags"].arrayValue.map({$0.stringValue})
		let eventDescription = Text(markdown: json["markdownDescription"].stringValue)
		let websiteURL = json["websiteURL"].stringValue
		let imageURL = json["imageURL"].stringValue
		let latitude = json["latitude"].double
		let longitude = json["longitude"].double
		let venue = json["venue"].stringValue
		let address = json["address"].stringValue
		let location = Location(latitude: latitude!, longitude: longitude!, address: address, venue: venue)
		let facebookEventID = json["facebookEventID"].stringValue
		let time = DateInterval(start: startDate!, end: endDate!)
		let hypePeriod = DateInterval(start: hypeStartDate!, end: hypeEndDate!)

		return GeneralEvent(title: title, time: time, tagLine: tagLine, color: color, hypePeriod: hypePeriod,
			tags: tags, description: eventDescription, websiteURL: websiteURL, imageURL: imageURL, location: location,
			facebookEventID: facebookEventID)
	}
}
