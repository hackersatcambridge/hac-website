import Foundation

protocol Event {
    var title : String {get}
    var time : DateInterval {get}
    var eventDescription: String {get} //NOT related to event content (e.g. workshop content)
    var color : String {get}
    var hypePeriod : DateInterval {get}
    var imageURL : String? {get}
    var venue : String? {get} //for room names etc.
    var facebookLink : String? {get}
    var shouldShowAsUpdate : Bool {get}
}