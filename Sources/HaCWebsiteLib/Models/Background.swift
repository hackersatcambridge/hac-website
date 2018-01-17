/// Models a visual background
enum Background {
  case image(String)
  case color(String)

  var style: [String: String] {
    switch (self) {
    case .image(let path):
      return ["background-image": "url('\(path)')"]
    case .color(let color):
      return ["background-color": color]
    }
  }
}

extension Background: Equatable {
  static func == (l: Background, r: Background) -> Bool {
    switch (l, r) {
      case (.image(let lPath), .image(let rPath)) where lPath == rPath:
        return true
      case (.color(let lColor), .color(let rColor)) where lColor == rColor:
        return true
      default:
        return false
    }
  }
}
