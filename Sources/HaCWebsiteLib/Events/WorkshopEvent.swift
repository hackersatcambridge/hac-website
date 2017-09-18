import Foundation

struct WorkshopEvent : Event {
    let title : String
    let time : Date 
    let eventDescription : String
    let color : String
    let hypePeriod : DateInterval
    let workshop : Workshop 
    var imageURL : String?
    var endTime : Date? 
    var venue : String?
    var facebookLink : String?
    var shouldShowAsUpdate: Bool {
        get {
            return self.hypePeriod.contains(Date())
        }
    }

    init(called title: String, at time: Date, described description: String, colored color: String, 
    hypePeriod: DateInterval, basedOn workshop: Workshop) {
        self.title = title
        self.time = time
        self.eventDescription = description
        self.color = color
        self.hypePeriod = hypePeriod
        self.workshop = workshop
    }
}

