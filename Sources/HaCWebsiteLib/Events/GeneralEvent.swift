import Foundation

struct GeneralEvent: PostCardRepresentable {
    let title : String
    let time : DateInterval
    let tagLine : String
    let color : String
    let hypePeriod : DateInterval
    let tags : [String]
    let eventDescription : Markdown
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
          backgroundColor: self.color, //TODO
          imageURL: self.imageURL
        )
    }

    init(title: String, time: DateInterval, tagLine: String, color: String,hypePeriod: DateInterval, 
    tags:[String], description eventDescription: Markdown, imageURL: String? = nil, location: Location? = nil,
    facebookEventID: String? = nil) {
        self.title = title
        self.time = time
        self.tagLine = tagLine
        self.color = color
        self.hypePeriod = hypePeriod
        self.tags = tags
        self.eventDescription = eventDescription
        self.imageURL = imageURL
        self.location = location
        self.facebookEventID = facebookEventID
    }

}