import HaCTML
import Foundation

struct Page: Nodeable {
  let title: String
  let postFixElements: Nodeable
  let content: Nodeable

  init(title: String = defaultTitle, postFixElements: Nodeable = Fragment(), content: Nodeable) {
    self.title = title
    self.postFixElements = postFixElements
    self.content = content
  }

  public var node: Node {
    return Fragment(
      El.Doctype,
      El.Html[Attr.lang => "en"].containing(
        El.Head.containing(
          El.Meta[Attr.charset => "UTF-8"],
          El.Meta[Attr.name => "viewport", Attr.content => "width=device-width, initial-scale=1"],
          El.Link[Attr.rel => "icon", Attr.type => "favicon/png", Attr.href => Assets.publicPath("/images/favicon.png")],
          El.Title.containing(title),
          Page.stylesheet(forUrl: Assets.publicPath("/styles/main.css")),
          postFixElements
        )
      ),
      El.Body.containing(
        errorReport,
        content,
        GAScript()
      )
    )
  }

  func render() -> String {
    return node.render()
  }

  /// Get a view of the `swift build` output if it didn't exit with exit code zero
  private var errorReport: Node? {
    if let errorData = try? Data(contentsOf: URL(fileURLWithPath: "swift_build.log")) {
      return Fragment(
        El.Pre.containing(
          El.Code[Attr.className => "BuildOutput__Error"].containing(String(data: errorData, encoding: String.Encoding.utf8) as String!)
        )
      )
    } else {
      return nil
    }
  }

  private static let defaultTitle = "Cambridge's student tech society | Hackers at Cambridge"

  public static func stylesheet(forUrl urlString: String) -> Node {
    return El.Link[Attr.rel => "stylesheet", Attr.type => "text/css", Attr.href => urlString]
  }
}
