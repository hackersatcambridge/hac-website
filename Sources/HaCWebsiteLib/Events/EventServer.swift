import Foundation

public struct EventServer {

    static func getEvents() -> [Event] {
        //TODO: source events from database
        let duration : Double = 4000000
        let workshopEvents : [Event] = WorkshopManager.workshops.map{
            (workshop: Workshop) -> WorkshopEvent in
                return WorkshopEvent(called: workshop.title, at: Date(), described: "There's Pizza", 
                    coloured: "purple", hypePeriod: DateInterval(start: Date(), duration: duration), basedOn: workshop)
        }.filter{ event in 
            event.isLive
        }
        let hackathonEvents = [HackathonEvent(called: "Game Gig 2017", at: Date(), described: "Fun and Games", 
            coloured: "black", hypePeriod: DateInterval(start: Date(), duration: duration), lasting: 3)]

       return workshopEvents + hackathonEvents
    }
}