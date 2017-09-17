import Foundation

struct HackathonEvent : Event {
    let title : String
    let time : Date 
    let eventDescription: String
    let colour : String
    let duration : Int
    var sponsor : String?
    var imageURL : String?
    var endTime : Date? 
    var venue : String?
    var facebookLink : String?

    init(called title: String, at time: Date, described description: String, coloured colour: String, lasting duration: Int) {
        self.title = title
        self.time = time
        self.eventDescription = description
        self.colour = colour
        self.duration = duration
    }
}
