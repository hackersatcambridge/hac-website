import Foundation

struct WorkshopEvent : Event {
    let title : String
    let time : Date 
    let eventDescription: String
    let colour: String
    let hypeDays : Int
    let ttlDays : Int
    let workshop : Workshop 
    var imageURL : String?
    var endTime : Date? 
    var venue : String?
    var facebookLink : String?

    init(called title: String, at time: Date, described description: String, coloured colour: String, 
    hypePeriod: Int, coolOffPeriod ttl: Int, basedOn workshop: Workshop) {
        self.title = title
        self.time = time
        self.eventDescription = description
        self.colour = colour
        self.hypeDays = hypePeriod
        self.ttlDays = ttl
        self.workshop = workshop
    }
}

