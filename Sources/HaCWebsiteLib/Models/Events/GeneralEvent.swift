import Foundation
import Fluent

final class GeneralEvent: Event, Entity {
  //This is missing a workshop attribute from the deprecated WorkshopEvent.swift
  let storage = Storage()
  let title : String
  let time : DateInterval
  let tagLine : String
  let color : String
  let hypePeriod : DateInterval
  let tags : [String]
  let eventDescription : Markdown
  let websiteURL : String?
  let imageURL : String? 
  let location : Location?
  let facebookEventID : String?
  var shouldShowAsUpdate : Bool {
    get {
      return self.hypePeriod.contains(Date())
    }   
  }
  var postCardRepresentation : PostCard {
    return PostCard(
        title: self.title,
        category: .general,
        description: self.tagLine,
        backgroundColor: self.color,
        imageURL: self.imageURL
    )
  }

  init(title: String, time: DateInterval, tagLine: String, color: String, hypePeriod: DateInterval, 
  tags:[String], description eventDescription: Markdown, websiteURL : String? = nil, imageURL: String? = nil, 
  location: Location? = nil, facebookEventID: String? = nil) {
    self.title = title
    self.time = time
    self.tagLine = tagLine
    self.color = color
    self.hypePeriod = hypePeriod
    self.tags = tags
    self.eventDescription = eventDescription
    self.websiteURL = websiteURL
    self.imageURL = imageURL
    self.location = location
    self.facebookEventID = facebookEventID
  }

  init(row: Row) throws {
    title = try row.get("title")
    tagLine = try row.get("tagLine")
    color = try row.get("color")
    tags = try row.get("tags")
    websiteURL = try row.get("websiteURL")
    imageURL = try row.get("imageURL")
    facebookEventID = try row.get("facebookEventID")

    let startDate : Date = try row.get("startDate")
    let endDate : Date = try row.get("endDate")
    let hypeStartDate : Date = try row.get("hypeStartDate")
    let hypeEndDate : Date = try row.get("hypeEndDate")
    let markdown : String = try row.get("markdown")

    time = DateInterval(start: startDate, end: endDate)
    hypePeriod = DateInterval(start: hypeStartDate, end: hypeEndDate)
    eventDescription = Markdown(markdown)
    guard let long : Double = try row.get("longitude"),
      let lat : Double = try row.get("latitude"),
      let address : String = try row.get("address"),
      let venue : String = try row.get("venue") else {
      location = nil
      return
    }
    location = Location(latitude: lat, longitude: long, address: address, venue: venue)
  }

  func makeRow() throws -> Row {
    var row = Row()
    try row.set("title", title)
    try row.set("startDate", time.start)
    try row.set("endDate", time.end)
    try row.set("tagLine", tagLine)
    try row.set("color", color)
    try row.set("hypeStartDate", hypePeriod.start)
    try row.set("hypeEndDate", hypePeriod.end)
    try row.set("tags", tags)
    try row.set("markdown", eventDescription.raw)
    try row.set("websiteURL", websiteURL)
    try row.set("imageURL", imageURL)
    try row.set("longitude", location?.longitude)
    try row.set("latitude", location?.latitude)
    try row.set("address", location?.address)
    try row.set("venue", location?.venue)
    try row.set("facebookEventID", facebookEventID)
    return row
  }
}

extension GeneralEvent {
  enum InitPreparation: Preparation {
    static func prepare(_ database: Database) throws {
      try database.create(GeneralEvent.self) { events in 
        events.id()
        events.string("title")
        events.date("startDate")
        events.date("endDate")
        events.string("tagLine")
        events.string("color")
        events.date("hypeStartDate")
        events.date("hypeEndDate")
        events.custom("tags", type: "TEXT[]")
        events.string("markdown")
        events.string("websiteURL", optional: true)
        events.string("imageURL", optional: true)
        events.double("latitude", optional: true)
        events.double("longitude", optional: true)
        events.string("address", optional: true)
        events.string("venue", optional: true)
        events.string("facebookEventID", optional: true)
      }
    }

    static func revert(_ database : Database) throws {
      try database.delete(GeneralEvent.self)
    }
  }
}
