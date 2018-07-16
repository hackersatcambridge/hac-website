import HaCTML
import LoggerAPI

// swiftlint:disable line_length

func formatDateString(_ str: String) -> String {
  var ret = str
  ret.removeLast(6)
  ret = ret.replacingOccurrences(of: " ", with: "T") 
  ret = ret + ".000"
  return ret
}

func getTagElements(fromList tags: [String]) -> [HTMLElement] {
  let htmlElements = tags.map{tag in 
    El.Input[Attr.className => "AddEventPage__formInput AddEventPage__tagInput", Attr.value => tag]
  }
  return htmlElements
}

struct EditEventPage: Nodeable {
  let event : GeneralEvent

  var node: Node {
    let websiteURL = event.websiteURL ?? ""
    let imageURL = event.imageURL ?? ""
    let venue = event.location?.venue ?? ""
    let address = event.location?.address ?? ""
    var longitudeString = "" 
    var latitudeString = ""
    if let location = event.location {
      longitudeString = String(location.longitude)
      latitudeString = String(location.latitude)
    }
    let facebookEventID = event.facebookEventID ?? ""
    let submitFormJS = """
      function submitForm() {
        var xhr = new XMLHttpRequest();
        var url = \"/beta/api/edit_event/\(event.eventId)\";
        xhr.open(\"POST\", url, true);
        xhr.setRequestHeader(\"Content-Type\", \"application/json\");
        xhr.onreadystatechange = function () {
          if (xhr.readyState === 4 && xhr.status === 200) {
            alert(\"Event edited successfully\");
            window.location.href = \"/beta/events-portal\";
          } 
        };
        let tagEls = Array.from(document.getElementsByClassName(\"AddEventPage__tagInput\"));
        var tags= tagEls.map(el => el.value);
        tags = tags.filter(function(entry) { return entry.trim() != ''; });

        var data = JSON.stringify(
          {
          \"eventId\": document.getElementById("eventId").value,
          \"title\": document.getElementById("title").value,
          \"startDate\": document.getElementById("startDate").value,
          \"endDate\": document.getElementById("endDate").value,
          \"tagLine\": document.getElementById("tagLine").value,
          \"color\": document.getElementById("color").value,
          \"hypeStartDate\": document.getElementById("hypeStartDate").value,
          \"hypeEndDate\": document.getElementById("hypeEndDate").value,
          \"tags\": tags,
          \"websiteURL\": document.getElementById("websiteURL").value,
          \"imageURL\": document.getElementById("imageURL").value,
          \"markdownDescription\": document.getElementById("markdownDescription").value,
          \"latitude\": parseFloat(document.getElementById("latitude").value),
          \"longitude\": parseFloat(document.getElementById("longitude").value),
          \"venue\": document.getElementById("venue").value,
          \"address\": document.getElementById("address").value,
          \"facebookEventID\": document.getElementById("facebookEventID").value
          }
        );
        xhr.send(data);
      }; submitForm();
    """
    let startDate = formatDateString(event.time.start.description)
    let endDate = formatDateString(event.time.end.description)
    let hypeStartDate = formatDateString(event.hypePeriod.start.description)
    let hypeEndDate = formatDateString(event.hypePeriod.end.description)
    let tagElements = getTagElements(fromList: event.tags)

    return Page(
      title: "Edit Event",
      content: Fragment(
        El.Div[Attr.className => "AddEventPage__mainContainer"].containing(
          El.H1[Attr.className => "AddEventPage__inputLabel"].containing("Edit Event"),
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("eventId"),
          El.Input[Attr.id => "eventId", Attr.className => "AddEventPage__formInput", Attr.value => event.eventId],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("title"),
          El.Input[Attr.id => "title", Attr.className => "AddEventPage__formInput", Attr.value => event.title],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("startDate"),
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("Dates should be of the form 'year-month-dateThour:min:sec.msec'. E.g. '2017-11-15T12:01:12.123'"),
          El.Input[Attr.id => "startDate", Attr.className => "AddEventPage__formInput", Attr.value => startDate],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("endDate"),
          El.Input[Attr.id => "endDate", Attr.className => "AddEventPage__formInput", Attr.value => endDate],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("tagLine"),
          El.Textarea[Attr.id => "tagLine", Attr.className => "AddEventPage__formInput"].containing(event.tagLine),
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("color"),
          El.Input[Attr.id => "color", Attr.className => "AddEventPage__formInput", Attr.value => event.color],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("hypeStartDate"),
          El.Input[Attr.id => "hypeStartDate", Attr.className => "AddEventPage__formInput", Attr.value => hypeStartDate],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("hypeEndDate"),
          El.Input[Attr.id => "hypeEndDate", Attr.className => "AddEventPage__formInput", Attr.value => hypeEndDate],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("tags"),
          El.Div[Attr.id => "tagInputContainer"].containing(
            tagElements
          ),
          El.Button[Attr.onClick => addNewTagJS, Attr.className => "AddEventPage__button"].containing("Add another tag"),
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("websiteURL"),
          El.Input[Attr.id => "websiteURL", Attr.className => "AddEventPage__formInput", Attr.value => websiteURL],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("imageURL"),
          El.Input[Attr.id => "imageURL", Attr.className => "AddEventPage__formInput", Attr.value => imageURL],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("markdownDescription"),
          El.Textarea[Attr.id => "markdownDescription", Attr.className => "AddEventPage__formInput"].containing(event.eventDescription.raw),
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("latitude"),
          El.Input[Attr.id => "latitude", Attr.className => "AddEventPage__formInput", Attr.value => latitudeString],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("longitude"),
          El.Input[Attr.id => "longitude", Attr.className => "AddEventPage__formInput", Attr.value => longitudeString],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("venue"),
          El.Input[ Attr.id => "venue", Attr.className => "AddEventPage__formInput", Attr.value => venue],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("address"),
          El.Input[Attr.id => "address", Attr.className => "AddEventPage__formInput", Attr.value => address],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("facebookEventID"),
          El.Input[Attr.id => "facebookEventID", Attr.className => "AddEventPage__formInput", Attr.value => facebookEventID],
          El.Button[Attr.onClick => submitFormJS, Attr.className => "AddEventPage__button"].containing("Submit")
        )
      )
    ).node
  }

  private let addNewTagJS = """
    var div = document.getElementById(\"tagInputContainer\");
    var newElement = document.createElement('input');
    newElement.className = \"AddEventPage__formInput AddEventPage__tagInput\";
    div.appendChild(newElement);
  """
}
