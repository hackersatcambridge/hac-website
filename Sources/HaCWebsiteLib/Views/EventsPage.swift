import HaCTML

// swiftlint:disable line_length

struct EventsPage: Nodeable {

  var node: Node {

    let events = EventServer.getAllEvents()
    let eventListItems = events.map({
      (event: GeneralEvent) -> Node in 
        EventView.getEventListItem(event)
      }
    )
    let eventsNumberText = "There are " + String(eventListItems.count) + " items in the database"
    return Page(
      title: "Events",
      content: Fragment(
        El.Div[Attr.className => "EventsPortal__mainContainer"].containing([
          El.Div.containing(eventsNumberText),
          El.H1.containing("Events in Database"),
          El.Div[Attr.className => "EventsPortal__divider"].containing(),
          El.Div.containing(eventListItems)
        ])
      )
    ).node
  }
}
