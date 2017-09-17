import Foundation

protocol Event {
    var title : String {get}
    var time : Date {get}
    var eventDescription: String {get} //NOT related to event content (e.g. workshop content)
    var colour : String {get}
    var hypeDays : Int {get}
    var ttlDays : Int {get}
    var imageURL : String? {get set}
    var endTime : Date? {get set}
    var venue : String? {get set} //for room names etc.
    var facebookLink : String? {get set}
}