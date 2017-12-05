import Foundation

/// Models a hyperlink
struct Link {
  let text: String
  let url: URL
}

extension Link: Equatable {
  static func == (l: Link, r: Link) -> Bool {
    return (l.text, l.url) == (r.text, r.url)
  }
}