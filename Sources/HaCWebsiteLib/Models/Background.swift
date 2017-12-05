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