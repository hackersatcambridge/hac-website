import HaCTML
import Foundation

struct BackBar: Nodeable {
  let backLinkText: String
  let backLinkURL: String
  var node: Node {
    return El.Div[
      Attr.className => "BackBar"
    ].containing(
      El.A[Attr.className => "BackBar__backButton", Attr.href => backLinkURL].containing(
        El.Div[Attr.className => "BigButton BigButton--back"].containing(
          backLinkText
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
