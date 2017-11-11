import Foundation

struct WorkshopEvent : Event {
    let title : String
    let time : DateInterval
    let tagLine : String
    let eventDescription : Markdown
    let color : String
    let hypePeriod : DateInterval
    let tags : [String]
    let workshop : Workshop 
    let imageURL : String?
    let location : Location?
    let facebookEventID : String?
    var shouldShowAsUpdate: Bool {
        get {
            return self.hypePeriod.contains(Date())
        }
    }
    var postCardRepresentation : PostCard {
        return PostCard(
          title: self.title,
          category: .workshop,
          description: self.tagLine,
          backgroundColor: self.color, //TODO
          imageURL: self.imageURL
        )
    }

    init(title: String, time: DateInterval, tagLine : String, description: Markdown, color: String,
    hypePeriod: DateInterval,  tags: [String], workshop: Workshop, imageURL: String? = nil, 
    location: Location? = nil, facebookEventID : String? = nil) {
        self.title = title
        self.time = time
        self.tagLine = tagLine
        self.eventDescription = description
        self.color = color
        self.hypePeriod = hypePeriod
        self.tags = tags
        self.workshop = workshop
        self.imageURL = imageURL
        self.location = location
        self.facebookEventID = facebookEventID
    }
}

