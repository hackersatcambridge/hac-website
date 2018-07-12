import Foundation

protocol Event: PostCardRepresentable {
    var eventId: String {get set}
    var title : String {get set}
    var time : DateInterval {get set}
    var tagLine : String {get set}
    var color : String {get set}
    var hypePeriod : DateInterval {get set}
    var tags : [String] {get set}
    var imageURL : String? {get set}
    var location : Location? {get set}
    var facebookEventID : String? {get set}
    var shouldShowAsUpdate : Bool {get}
}