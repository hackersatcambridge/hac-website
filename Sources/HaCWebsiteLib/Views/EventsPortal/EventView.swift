import HaCTML

struct EventView {
  public static func getEventShortDescription(from event: GeneralEvent) -> Node {
    return El.Div[Attr.className => "EventsPortal__eventContainer"].containing(
      El.H2.containing(event.title),
      El.A[Attr.href => ("/beta/events/delete_event/" + event.eventId)].containing("Delete Event..."),
      El.Br,
      El.A[Attr.href => ("/beta/events/edit_event/" + event.eventId)].containing("Edit Event..."),
      El.Br,
      El.A[Attr.href => ("/beta/events/" + event.eventId)].containing("View Event Individually..."),
      El.Div.containing("Id: " + event.eventId),
      El.Div.containing("Time: " + event.time.debugDescription),
      El.Div.containing("Tagline: " + event.tagLine),
      El.Br,
      El.Div[Attr.className => "EventsPortal__divider"].containing()
    )
  }


  public static func getEventFullDescription(from event: GeneralEvent) -> Node {
    var tagsText = "Tags: "
    for tag in event.tags { tagsText += "\(tag), "}
    var venue = "Venue: No Location", addr = "Address: No Location", long = "Longitude: No Location", lat = "Latitude: No Location"
    if let location = event.location {
      venue = "Venue: " + (location.venue ?? "null")
      addr = "Address: " + (location.address ?? "null")
      long = "Longitude: " + String(location.longitude)
      lat = "Latitude: " + String(location.latitude)
    }

    return El.Div[Attr.className => "EventsPortal__eventContainer"].containing(
      El.H2.containing(event.title),
      El.A[Attr.href => ("/beta/events/delete_event/" + event.eventId)].containing("Delete Event..."),
      El.Br,
      El.A[Attr.href => ("/beta/events/edit_event/" + event.eventId)].containing("Edit Event..."),
      El.Br,
      El.A[Attr.href => ("/beta/events/" + event.eventId)].containing("View Event Individually..."),
      El.Div.containing("Id: " + event.eventId),
      El.Div.containing("Time: " + event.time.debugDescription),
      El.Div.containing("Tagline: " + event.tagLine),
      El.Div.containing("Color: " + event.color),
      El.Div.containing("Hype period: " + event.hypePeriod.description),
      El.Div.containing(tagsText),
      El.Div.containing("Markdown Event Description: " + event.eventDescription.raw),
      El.Div.containing("WebsiteURL: " + (event.websiteURL ?? "null")),
      El.Div.containing("ImageURL: " + (event.imageURL ?? "null")),
      El.Div.containing("Facebook ID: " + (event.facebookEventID ?? "null")),
      El.Br,
      El.H4.containing("Location: "),
      El.Div.containing(venue),
      El.Div.containing(addr),
      El.Div.containing(long),
      El.Div.containing(lat),
      El.Br
    )
  }
}