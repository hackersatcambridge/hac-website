import Foundation

struct WorkshopEvent : Event {
    let title : String
    let time : Date 
    let eventDescription: String
    let colour: String
    let workshop : Workshop 
    var imageURL : String?
    var endTime : Date? 
    var venue : String?
    var facebookLink : String?

    init(called title: String, at time: Date, described description: String, coloured colour: String, basedOn workshop: Workshop) {
        self.title = title
        self.time = time
        self.eventDescription = description
        self.colour = colour
        self.workshop = workshop
    }
}

