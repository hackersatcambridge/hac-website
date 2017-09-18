import Foundation

protocol Event {
    var title : String {get}
    var time : DateInterval {get}
    var tagLine : String {get}
    var color : String {get}
    var hypePeriod : DateInterval {get}
    var imageURL : String? {get}
    var location : Location? {get}
    var facebookEventID : Double? {get}
    var shouldShowAsUpdate : Bool {get}
}