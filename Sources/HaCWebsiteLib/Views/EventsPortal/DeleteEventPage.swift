import HaCTML
import LoggerAPI

// swiftlint:disable line_length

struct DeleteEventPage: Nodeable {
  let eventId: String

  var node: Node {
    let submitFormJS = """
    function submitForm() {
    var xhr = new XMLHttpRequest();
    var url = \"/beta/api/delete_event\";
    xhr.open(\"POST\", url, true);
    xhr.setRequestHeader(\"Content-Type\", \"application/json\");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            alert(\"Event deleted successfully\");
            window.location.href = \"/beta/events-portal\";
        }
    };

    var data = JSON.stringify(
      {
      \"eventId\": \"\(eventId)\",
      }
    );
    xhr.send(data);
    }; submitForm();
    """

    let buttonText = "Delete event with id: " + eventId

    return Page(
      title: "Delete Event",
      content: Fragment(
        El.Div[Attr.className => "DeleteEventPage__mainContainer"].containing(
          El.H1[Attr.className => "DeleteEventPage__item"].containing("Delete Event"),
          El.Button[Attr.className => "DeleteEventPage__item", Attr.onClick => submitFormJS].containing(buttonText)
        )
      )
    ).node
  }
}
