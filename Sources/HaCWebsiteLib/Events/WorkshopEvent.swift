import Foundation

struct WorkshopEvent : Event {
    let title : String
    let time : DateInterval
    let eventDescription : String
    let color : String
    let hypePeriod : DateInterval
    let workshop : Workshop 
    let imageURL : String?
    let venue : String?
    let facebookLink : String?
    var shouldShowAsUpdate: Bool {
        get {
            return self.hypePeriod.contains(Date())
        }
    }

    init(called title: String, at time: DateInterval, described description: String, colored color: String, 
    hypePeriod: DateInterval, basedOn workshop: Workshop, imageURL: String? = nil,at venue: String? = nil,
    facebookLink : String? = nil) {
        self.title = title
        self.time = time
        self.eventDescription = description
        self.color = color
        self.hypePeriod = hypePeriod
        self.workshop = workshop
        self.imageURL = imageURL
        self.venue = venue
        self.facebookLink = facebookLink
    }
}

