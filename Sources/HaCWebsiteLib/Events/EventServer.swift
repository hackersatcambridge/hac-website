import Foundation

public struct EventServer {

  static func getEvents() -> [GeneralEvent] {
    //TODO: source events from database
    let hypeDuration : Double = 4000000
    let duration : Double = 4000
    let workshopEvents : [GeneralEvent] = WorkshopManager.workshops.map{
      (workshop: Workshop) -> GeneralEvent in
        return GeneralEvent(title: workshop.title, time:  DateInterval(start: Date(), duration: duration),
          tagLine: "There's Pizza", color: "purple", hypePeriod: DateInterval(start: Date(), duration: hypeDuration),
          tags: ["tag1", "tag2"], description: Markdown("Thing"))
    }.filter{ event in 
      event.shouldShowAsUpdate
    }
    let externalEvent = GeneralEvent(title: "Game Gig 2017", time: DateInterval(start: Date(), duration: duration),
      tagLine: "Fun and Games", color: "black", hypePeriod: DateInterval(start: Date(), duration: hypeDuration),
      tags: [], description: Markdown("Thing"))
    let externalEvents = [externalEvent]
    return workshopEvents + externalEvents
  }
}