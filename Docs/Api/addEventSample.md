### Example curl command to add an event from a JSON file in the same directory

```
curl -X POST -H "Content-Type: application/json" -d @customEvent.json http://charlie:secret@localhost:3000/api/add_event
```

### Example JSON with required fields of a GeneralEvent class
```
{
    "title":"Workshop Title",
    "startDate":"2017-11-20T12:01:12.123",
    "endDate":"2017-11-21T12:01:12.123",
    "tagLine":"This-is-a-tagline",
    "color":"purple",
    "hypeStartDate":"2017-11-15T12:01:12.123",
    "hypeEndDate":"2017-11-25T12:01:12.123",
    "tags": ["tag1", "tag2"],
    "eventDescription": "This is a plain description",
    "websiteURL":"www.website.com",
    "imageURL":"www.website.com",
    "markdownDescription":"plain markdown",
    "latitude":0,
    "longitude": 0,
    "venue":"cambridge computer lab",
    "address": "an address",
    "facebookEventID":"109"
}
```