import HaCTML
import LoggerAPI

// swiftlint:disable line_length

struct AddEventForm: Nodeable {

  var node: Node {
    return Page(
      title: "Add Event",
      content: Fragment(
        El.Div[Attr.className => "AddEventPage__mainContainer"].containing(
          El.H1[Attr.className => "AddEventPage__inputLabel"].containing("Add a new event to the Database"),
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("eventId"),
          El.Input[Attr.id => "eventId", Attr.className => "AddEventPage__formInput"],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("title"),
          El.Input[Attr.id => "title", Attr.className => "AddEventPage__formInput"],
          El.H4[Attr.className => "AddEventPage__inputLabel"].containing("Event Duration"),
          El.Div[Attr.className => "EventPage__durationInputContainer"].containing( 
            El.Div[Attr.className => "EventPage__timeInputContainer--left"].containing(
              El.Div[Attr.className => "AddEventPage__inputLabel"].containing("Start Time (24hrs)"),
              El.Input[Attr.type => "time", Attr.id => "startTime", Attr.step => "1"],
              El.Div[Attr.className => "AddEventPage__inputLabel"].containing("Start Date"),
              El.Input[Attr.type => "date", Attr.id => "startDate"]
            ),
            El.Div[Attr.className => "EventPage__timeInputContainer--right"].containing(
              El.Div[Attr.className => "AddEventPage__inputLabel"].containing("End Time (24hrs)"),
              El.Input[Attr.type => "time", Attr.id => "endTime", Attr.step => "1"],
              El.Div[Attr.className => "AddEventPage__inputLabel"].containing("End Date"),
              El.Input[Attr.type => "date", Attr.id => "endDate"]
            )
          ),
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("tagLine"),
          El.Textarea[Attr.id => "tagLine", Attr.className => "AddEventPage__formInput"].containing(),
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("color"),
          El.Input[Attr.id => "color", Attr.className => "AddEventPage__formInput"],
          El.H4[Attr.className => "AddEventPage__inputLabel"].containing("Event Hype Duration"),
          El.Div[Attr.className => "EventPage__durationInputContainer"].containing( 
            El.Div[Attr.className => "EventPage__timeInputContainer--left"].containing(
              El.Div[Attr.className => "AddEventPage__inputLabel"].containing("Start Time (24hrs)"),
              El.Input[Attr.type => "time", Attr.id => "startHypeTime", Attr.step => "1"],
              El.Div[Attr.className => "AddEventPage__inputLabel"].containing("Start Date"),
              El.Input[Attr.type => "date", Attr.id => "startHypeDate"]
            ),
            El.Div[Attr.className => "EventPage__timeInputContainer--right"].containing(
              El.Div[Attr.className => "AddEventPage__inputLabel"].containing("End Time (24hrs)"),
              El.Input[Attr.type => "time", Attr.id => "endHypeTime", Attr.step => "1"],
              El.Div[Attr.className => "AddEventPage__inputLabel"].containing("End Date"),
              El.Input[Attr.type => "date", Attr.id => "endHypeDate"]
            )
          ),
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("tags"),
          El.Div[Attr.id => "tagInputContainer"].containing(
            El.Input[Attr.className => "AddEventPage__formInput AddEventPage__tagInput"]
          ),
          El.Button[Attr.onClick => addNewTagJS, Attr.className => "AddEventPage__button"].containing("Add another tag"),
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("websiteURL"),
          El.Input[Attr.id => "websiteURL", Attr.className => "AddEventPage__formInput"],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("imageURL"),
          El.Input[Attr.id => "imageURL", Attr.className => "AddEventPage__formInput"],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("markdownDescription"),
          El.Textarea[Attr.id => "markdownDescription", Attr.className => "AddEventPage__formInput"].containing(),
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("latitude"),
          El.Input[Attr.id => "latitude", Attr.className => "AddEventPage__formInput"],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("longitude"),
          El.Input[Attr.id => "longitude", Attr.className => "AddEventPage__formInput"],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("venue"),
          El.Input[ Attr.id => "venue", Attr.className => "AddEventPage__formInput"],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("address"),
          El.Input[Attr.id => "address", Attr.className => "AddEventPage__formInput"],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("facebookEventID"),
          El.Input[Attr.id => "facebookEventID", Attr.className => "AddEventPage__formInput"],
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

  private let submitFormJS = """
    function submitForm() {
    var xhr = new XMLHttpRequest();
    var url = \"/api/add_event\";
    xhr.open(\"POST\", url, true);
    xhr.setRequestHeader(\"Content-Type\", \"application/json\");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
          alert(\"Event added successfully\");
          window.location.href = \"/beta/events-portal\";
        }
    };
    let tagEls = Array.from(document.getElementsByClassName(\"AddEventPage__tagInput\"));
    var tags = tagEls.map(el => el.value);
    tags = tags.filter(function(entry) { return entry.trim() != ''; });
    let startTime = document.getElementById(\"startTime\").value + \".000\";
    let endTime = document.getElementById(\"endTime\").value + \".000\";
    let startHypeTime = document.getElementById(\"startHypeTime\").value + \".000\";
    let endHypeTime = document.getElementById(\"endHypeTime\").value + \".000\";
    let startDate = document.getElementById(\"startDate\").value;
    let endDate = document.getElementById(\"endDate\").value;
    let startHypeDate = document.getElementById(\"startHypeDate\").value;
    let endHypeDate = document.getElementById(\"endHypeDate\").value;

    var data = JSON.stringify(
      {
      \"eventId\": document.getElementById("eventId").value,
      \"title\": document.getElementById("title").value,
      \"startDate\": startDate + 'T' + startTime,
      \"endDate\": endDate + 'T' + endTime,
      \"tagLine\": document.getElementById("tagLine").value,
      \"color\": document.getElementById("color").value,
      \"hypeStartDate\": startHypeDate + 'T' + startHypeTime,
      \"hypeEndDate\": endHypeDate + 'T' + endHypeTime,
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
}
