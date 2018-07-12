import Foundation

protocol Event: PostCardRepresentable {
    var eventId: String {get}
    var title : String {get}
    var time : DateInterval {get}
    var tagLine : String {get}
    var color : String {get}
    var hypePeriod : DateInterval {get}
    var tags : [String] {get}
    var imageURL : String? {get}
    var location : Location? {get}
    var facebookEventID : String? {get}
    var shouldShowAsUpdate : Bool {get}
}