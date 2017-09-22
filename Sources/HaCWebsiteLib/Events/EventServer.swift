import Foundation

public struct EventServer {

    static func getEvents() -> [Event] {
        //TODO: source events from database
        let hypeDuration : Double = 4000000
        let duration : Double = 4000
        let workshopEvents : [Event] = WorkshopManager.workshops.map{
            (workshop: Workshop) -> WorkshopEvent in
                return WorkshopEvent(title: workshop.title, time:  DateInterval(start: Date(), duration: duration),
                    tagLine: "There's Pizza", description: Text(markdown : "Thing"), color: "purple", 
                    hypePeriod: DateInterval(start: Date(), duration: hypeDuration), tags: [], workshop: workshop)
        }.filter{ event in 
            event.shouldShowAsUpdate
        }
        let externalEvent = ExternalWebsiteEvent(title: "Game Gig 2017", time: DateInterval(start: Date(), duration: duration),
            tagLine: "Fun and Games", color: "black", hypePeriod: DateInterval(start: Date(), duration: hypeDuration), tags: [])
        let externalEvents = [externalEvent]
       return workshopEvents + externalEvents
    }
}