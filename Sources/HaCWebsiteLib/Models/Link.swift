import Foundation

/// Models a hyperlink
struct Link {
  let title: String
  let url: URL
}

extension Link: Equatable {
  static func == (l: Link, r: Link) -> Bool {
    return (l.title, l.url) == (r.title, r.url)
  }
}