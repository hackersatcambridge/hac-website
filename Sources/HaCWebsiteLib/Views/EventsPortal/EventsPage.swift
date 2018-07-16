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
    let count = eventListItems.count
    let innerString = (count == 1 ? "is \(count) item" : "are \(count) items")
    let eventsNumberText = "There \(innerString) in the database"

    return Page(
      title: "Events",
      content: Fragment(
        El.Div[Attr.className => "EventsPortal__mainContainer"].containing([
          El.Div.containing(eventsNumberText),
          El.Div.containing("The available routes for interacting with the events API are /beta/events/edit_event/:eventId /beta/events/add_event, /beta/events/delete_event/:eventid and /beta/events/:eventId "),
          El.A[Attr.href => "/beta/events/add_event"].containing("Add new event..."),
          El.H1.containing("Events in Database"),
          El.Div[Attr.className => "EventsPortal__divider"].containing(),
          El.Div.containing(eventListItems)
        ])
      )
    ).node
  }
}
