import Foundation

public struct EventServer {

    static func getEvents() -> [Event] {
        //TODO: source events from database
        let hypeDuration : Double = 4000000
        let duration : Double = 4000
        let workshopEvents : [Event] = WorkshopManager.workshops.map{
            (workshop: Workshop) -> WorkshopEvent in
                return WorkshopEvent(called: workshop.title, at:  DateInterval(start: Date(), duration: duration),
                    described: "There's Pizza", colored: "purple", 
                    hypePeriod: DateInterval(start: Date(), duration: hypeDuration), basedOn: workshop)
        }.filter{ event in 
            event.shouldShowAsUpdate
        }
        let hackathon = HackathonEvent(called: "Game Gig 2017", at: DateInterval(start: Date(), duration: duration),
            described: "Fun and Games", colored: "black", hypePeriod: DateInterval(start: Date(), duration: hypeDuration))
        let hackathonEvents = [hackathon]
       return workshopEvents + hackathonEvents
    }
}