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
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("startDate"),
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("Dates should be of the form 'year-month-dateThour:min:sec.msec'. E.g. '2017-11-15T12:01:12.123'"),
          El.Input[Attr.id => "startDate", Attr.className => "AddEventPage__formInput"],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("endDate"),
          El.Input[Attr.id => "endDate", Attr.className => "AddEventPage__formInput"],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("tagLine"),
          El.Textarea[Attr.id => "tagLine", Attr.className => "AddEventPage__formInput"].containing(),
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("color"),
          El.Input[Attr.id => "color", Attr.className => "AddEventPage__formInput"],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("hypeStartDate"),
          El.Input[Attr.id => "hypeStartDate", Attr.className => "AddEventPage__formInput"],
          El.Div[Attr.className => "AddEventPage__inputLabel"].containing("hypeEndDate"),
          El.Input[Attr.id => "hypeEndDate", Attr.className => "AddEventPage__formInput"],
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
    let tags = tagEls.map(el => el.value);

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
}
