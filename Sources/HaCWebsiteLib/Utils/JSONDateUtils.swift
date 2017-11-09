import SwiftyJSON
import Foundation

class JSONDateFormatter {
    static let jsonDateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
}

extension JSON {
    public var dateTime: Date? {
        get {
            switch self.type {
            case .string:
                return JSONDateFormatter.jsonDateTimeFormatter.date(from: self.object as! String)
            default:
                return nil
            }
        }
    }
    
}