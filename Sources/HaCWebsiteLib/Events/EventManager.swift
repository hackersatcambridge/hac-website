import Foundation

public struct EventManager {
    private(set) static var events: [Event] = []

    public static func update() throws{
        var updatedEvents : [Event] = []

        let duration : Double = 4000000
        try! WorkshopManager.update()
        //TODO: source events from database
        let workshopEvents : [Event] = WorkshopManager.workshops.map{
            (workshop: Workshop) -> WorkshopEvent in
                return WorkshopEvent(called: workshop.title, at: Date(), described: "There's Pizza", 
                    coloured: "purple", hypePeriod: DateInterval(start: Date(), duration: duration), basedOn: workshop)
        }.filter{ event in 
            event.isLive
        }
        updatedEvents += workshopEvents

        updatedEvents += [HackathonEvent(called: "Game Gig 2017", at: Date(), described: "Fun and Games", 
            coloured: "black", hypePeriod: DateInterval(start: Date(), duration: duration), lasting: 3)]

        events = updatedEvents
    }
}
