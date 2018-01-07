import HaCTML
import Foundation

struct BackBar: Nodeable {
  var node: Node {
    return El.Div[
      Attr.className => "BackBar"
    ].containing(
      El.A[Attr.className => "BackBar__backButton", Attr.href => "/"].containing(
        El.Div[Attr.className => "BigButton"].containing(
          "Home"
        )
      ),
      El.Img[
        Attr.className => "BackBar__branding SiteLogo SiteLogo--small",
        Attr.src => Assets.publicPath("/images/hac-logo-dark.svg"),
        Attr.alt => "Hackers at Cambridge"
      ]
    )
  }
}
