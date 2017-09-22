import Foundation

struct ExternalWebsiteEvent : Event {
    let title : String
    let time : DateInterval
    let tagLine : String
    let color : String
    let hypePeriod : DateInterval
    let imageURL : String?
    let location : Location?
    let facebookEventID : Double?
    var shouldShowAsUpdate: Bool {
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

    init(called title: String, at time: DateInterval, summarised tagLine : String, colored color: String, 
    hypePeriod: DateInterval, imageURL: String? = nil, at location: Location? = nil, facebookEventID : Double? = nil ) {
        self.title = title
        self.time = time
        self.tagLine = tagLine
        self.color = color
        self.hypePeriod = hypePeriod
        self.imageURL = imageURL
        self.location = location
        self.facebookEventID = facebookEventID
    }
}
