import Foundation

protocol Event {
    var title : String {get}
    var time : Date {get}
    var eventDescription: String {get} //NOT related to event content (e.g. workshop content)
    var color : String {get}
    var hypePeriod : DateInterval {get}
    var imageURL : String? {get set}
    var endTime : Date? {get set}
    var venue : String? {get set} //for room names etc.
    var facebookLink : String? {get set}
    var shouldShowAsUpdate : Bool {get}
}