import Foundation

protocol Event {
    var title : String {get}
    var time : Date {get}
    var eventDescription: String {get} //NOT related to event content (e.g. workshop content)
    var color : String {get}
    var hypePeriod : DateInterval {get}
    var imageURL : String? {get}
    var endTime : Date? {get}
    var venue : String? {get} //for room names etc.
    var facebookLink : String? {get}
    var shouldShowAsUpdate : Bool {get}
}