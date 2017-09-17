import Foundation

public struct EventManager {
    private(set) static var events: [Event] = []

    public static func update() throws{
        var updatedEvents : [Event] = []

        try! WorkshopManager.update()
        //TODO: source events from database
        let workshopEvents : [Event] = WorkshopManager.workshops.map{(workshop: Workshop) -> WorkshopEvent in
            return WorkshopEvent(called: workshop.title, at: Date(), described: "There's Pizza", coloured: "yellow", basedOn: workshop)
        }
        updatedEvents += workshopEvents

        updatedEvents += [HackathonEvent(called: "Game Gig 2017", at: Date(), described: "Fun and Games", 
            coloured: "black", hypePeriod: 7, coolOffPeriod: 7, lasting: 3)]

        events = updatedEvents
    }
}