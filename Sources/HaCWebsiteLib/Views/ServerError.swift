import HaCTML

struct ServerError: Nodeable {
  var node: Node {
    return Page(
      title: "Server Error",
      content: Fragment(
        El.Div[Attr.className => "ServerError"].containing(
          El.Img[
            Attr.className => "SiteLogo",
            Attr.src => Assets.publicPath("/images/hac-logo-dark.svg"),
            Attr.alt => "Hackers at Cambridge"
          ],
          El.Div[Attr.className => "TagLine"].containing("Cambridge's student tech society"),
          El.H1[Attr.className => "ServerError__title"].containing("500"),
          El.P.containing("An internal error has occured..."),
          El.A[Attr.href => "/"].containing(
            El.Div[Attr.className => "BigButton"].containing(
              "Home"
            )
          )
        )
      )
    ).node
  }
}
