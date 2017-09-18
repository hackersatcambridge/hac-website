import Foundation

struct HackathonEvent : Event, PostCardRepresentable {
    let title : String
    let time : DateInterval
    let eventDescription: String
    let color : String
    let hypePeriod : DateInterval
    let sponsor : String?
    let imageURL : String?
    let location : Location?
    let facebookID : Double?
    var shouldShowAsUpdate: Bool {
        get {
            return self.hypePeriod.contains(Date())
        }
    }
    var postCardRepresentation : PostCard {
        return PostCard(
          title: self.title,
          category: .hackathon,
          description: self.eventDescription,
          backgroundColor: self.color, //TODO
          imageURL: self.imageURL
        )
    }

    init(called title: String, at time: DateInterval, described description: String, colored color: String, 
    hypePeriod: DateInterval, sponsoredBy sponsor: String? = nil, imageURL: String? = nil,
    at location: Location? = nil, facebookID : Double? = nil ) {
        self.title = title
        self.time = time
        self.eventDescription = description
        self.color = color
        self.hypePeriod = hypePeriod
        self.sponsor = sponsor
        self.imageURL = imageURL
        self.location = location
        self.facebookID = facebookID
    }
}
