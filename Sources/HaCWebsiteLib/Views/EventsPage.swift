import HaCTML

// swiftlint:disable line_length
func getEventListItem(_ event: GeneralEvent) -> Node {
  let titleText = "Title: " + event.title
  //TODO: let timetext = event.time
  let tagLineText = "Tagline: " + event.tagLine
  let colorText = "Color: " + event.color
  //TODO: let hypePeriodText = event.hypePeriod
  //TODO: let tagsText = event.tags
  //TODO: let eventDescriptionText = event.eventDescription
  let websiteURLText = "WebsiteURL: " + (event.websiteURL ?? "null")
  let imageURLText = "ImageURL: " + (event.imageURL ?? "null")
  //TODO: let locationText = event.location
  let facebookEventIDText = "Facebook ID: " + (event.facebookEventID ?? "null")

  return El.Div.containing(
    El.Header.containing(titleText),
    //TODO El.Header.containing(timeText),
    El.Header.containing(tagLineText),
    El.Header.containing(colorText),
    //TODO: El.Header.containing(hypeStartDateText),
    //TODO: El.Header.containing(tagsText),
    //TODO: El.Header.containing(eventDescriptionText),
    El.Header.containing(websiteURLText),
    El.Header.containing(imageURLText),
    //TODO: El.Header.containing(locationText),
    El.Header.containing(facebookEventIDText),
    El.Div[Attr.className => "EventsPortal__divider"].containing()
  )
}

struct EventsPage: Nodeable {

  var node: Node {

    let events = EventServer.getAllEvents()
    let eventListItems = events.map({
      (event: GeneralEvent) -> Node in 
        getEventListItem(event)
      }
    )
    let eventsNumberText = "There are " + String(eventListItems.count) + " items in the database"
    return Page(
      title: "Events",
      content: Fragment(
        El.Div.containing([
          El.Div.containing(eventsNumberText),
          El.H1.containing("Events in Database"),
          El.Div[Attr.className => "EventsPortal__divider"].containing(),
          El.Div.containing(eventListItems)
        ])
      )
    ).node
  }
}
