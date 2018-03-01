import XCTest
@testable import HaCWebsiteLib

class EventApiControllerTests: HaCWebsiteLibTestCase {

    func testParseEventMissingParameters() {
        let badJson = [
            "bleh": "hehe",
        ]
        XCTAssertThrowsError(try EventApiController.parseEvent(json: badJson)) { error in
            XCTAssertEqual(error as? EventParsingError, EventParsingError.missingParameters)
        }
    }

    func testParseEventInvalidHypePeriod() {
        // Hype period doesn't contain event dates itself!
        let badHypePeriodJson : [String: Any] = [
            "title":"Workshop Title",
            "startDate":"2017-11-20T12:01:12.123",
            "endDate":"2017-11-21T12:01:12.123",
            "tagLine":"This-is-a-tagline",
            "color":"purple",
            "hypeStartDate":"2017-11-11T12:01:13.123",
            "hypeEndDate":"2017-11-12T12:01:12.123",
            "tags": ["tag1", "tag2"],
            "eventDescription": "This is a plain description",
            "websiteURL":"www.website.com",
            "imageURL":"www.website.com",
            "markdownDescription":"plain markdown",
            "latitude":0,
            "longitude": 0,
            "venue":"cambridge computer lab",
            "address": "an address",
            "facebookEventID":"109",
        ]
        XCTAssertThrowsError(try EventApiController.parseEvent(json: badHypePeriodJson)) { error in
            XCTAssertEqual(error as? EventParsingError, EventParsingError.invalidHypePeriod)
        }
    }

    func testParseEvent() throws {
        // Hype period doesn't contain event dates itself!
        let json : [String: Any] = [
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
            "facebookEventID":"109",
        ]
        let generalEvent = try EventApiController.parseEvent(json: json)
        XCTAssertEqual(generalEvent.title, "Workshop Title")
    }

    static var allTests : [(String, (EventApiControllerTests) -> () throws -> Void)] {
    return [
      ("testParseEventMissingParameters", testParseEventMissingParameters),
      ("testParseEventInvalidHypePeriod", testParseEventInvalidHypePeriod),
      ("testParseEvent", testParseEvent),
    ]
  }
}