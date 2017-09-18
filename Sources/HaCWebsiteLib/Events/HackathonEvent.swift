import Foundation

struct HackathonEvent : Event {
    let title : String
    let time : Date 
    let eventDescription: String
    let color : String
    let duration : Int
    let hypePeriod : DateInterval
    let sponsor : String?
    let imageURL : String?
    let endTime : Date? 
    let venue : String?
    let facebookLink : String?
    var shouldShowAsUpdate: Bool {
        get {
            return self.hypePeriod.contains(Date())
        }
    }

    init(called title: String, at time: Date, described description: String, colored color: String, 
    hypePeriod: DateInterval, lasting duration: Int, sponsoredBy sponsor: String? = nil, imageURL: String? = nil,
    finishing endTime: Date? = nil, at venue: String? = nil, facebookLink : String? = nil ) {
        self.title = title
        self.time = time
        self.eventDescription = description
        self.color = color
        self.hypePeriod = hypePeriod
        self.duration = duration
        self.sponsor = sponsor
        self.imageURL = imageURL
        self.endTime = endTime
        self.venue = venue
        self.facebookLink = facebookLink
    }
}
