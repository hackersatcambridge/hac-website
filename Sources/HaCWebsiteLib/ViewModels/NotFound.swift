import HaCTML

struct NotFound: Nodeable {
  var node: Node {
    return Page(
      title: "Page Not Found",
      content: Fragment(
        El.Div[Attr.className => "NotFound"].containing(
          El.Img[
            Attr.className => "SiteLogo",
            Attr.src => Assets.publicPath("/images/hac-logo-dark.svg"),
            Attr.alt => "Hackers at Cambridge"
          ],
          El.Div[Attr.className => "TagLine"].containing("Cambridge's student tech society"),
          El.H1[Attr.className => "NotFound__title"].containing("404"),
          El.P.containing("We can't find the page you're looking for..."),
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
