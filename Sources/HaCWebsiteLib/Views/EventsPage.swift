import HaCTML

// swiftlint:disable line_length
func getEventListItem(_ event: GeneralEvent) -> Node {
  return El.Div[].containing("Node")
}

struct EventsPage: Nodeable {

  var node: Node {

    let events = EventServer.getAllEvents()
    let eventListItems = events.map({
      (event: GeneralEvent) -> Node in getEventListItem(event)}
    )
    let eventsNoText = "There are " + String(eventListItems.count) + " items in the database"
    return Page(
      title: "Events",
      content: Fragment(
        El.Div[].containing([
          El.Div[].containing(eventsNoText),
          El.Div.containing(eventListItems)
        ])
      )
    ).node
  }
}
