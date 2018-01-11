import HaCTML

struct WorkshopsIndexAbout: Nodeable {
  var node: Node {
    return El.Div[Attr.className => "WorkshopsIndexPage__about WorkshopsIndexAbout"].containing(
      El.H2[Attr.className => "Text--headline"].containing("Workshops"),
      Markdown("""
        Run by members of the community and open to everyone, our workshops aim to inspire and to teach practical technology skills.
        
        If you are in Cambridge then you can come along to any of our workshops. They're always free.
        If you aren't in Cambridge or can't make it to a workshop live then you'll find the workshop material available here on our website and on GitHub.
        
        We make recordings of workshops available whenever we can
      """),
      El.A[
        Attr.href => "https://www.youtube.com/hackersatcambridge",
        Attr.target => "_blank",
        Attr.className => "BigButton BigButton--youtube"
      ].containing(
        "See recordings on YouTube"
      )
    )
  }
}