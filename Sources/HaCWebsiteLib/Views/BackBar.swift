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
      El.A[Attr.href => "/", Attr.className => "BackBar__branding"].containing(
        El.Img[
          Attr.className => "SiteLogo SiteLogo--small BackBar__branding__full",
          Attr.src => Assets.publicPath("/images/hac-logo-dark.svg"),
          Attr.alt => "Hackers at Cambridge"
        ],
        El.Img[
          Attr.className => "SiteLogo SiteLogo--small SiteLogo--short BackBar__branding__short",
          Attr.src => Assets.publicPath("/images/hac-logo-small-dark.svg"),
          Attr.alt => "Hackers at Cambridge"
        ]
      )
    )
  }
}
