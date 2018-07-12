import HaCTML

// swiftlint:disable line_length

struct IndividualEventPage: Nodeable {
  let event: GeneralEvent

  var node: Node {
    return Page(
      title: "Event",
      content: EventView.getEventListItem(event)
    ).node
  }
}
