### Example curl command to edit an event from a JSON file in the same directory

```
curl -X POST -H "Content-Type: application/json" -d @editEvent.json http://charlie:secret@localhost:3000/api/edit_event
```

### Example JSON with required field to identify target event and a new value for the title field

```
{
    "eventId": "workshop-id-2",
    "title":"Better Workshop Title"
}
```

Note - The parameters that can be used to trigger updates are identical to the parameters which can be included when adding events via the add_events api.