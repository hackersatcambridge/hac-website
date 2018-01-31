import HaCTML

/// Above-the-fold for the WorkshopsIndexPage
struct WorkshopsIndexArchive: Nodeable {
  let workshops: [Workshop]

  var node: Node {
    return El.Div[Attr.className => "WorkshopsIndexPage__archive"].containing(
      El.H2[Attr.className => "Text--sectionHeading"].containing("Browse Workshops"),
      El.Ul[Attr.className => "WorkshopsIndexPage__archive__list"].containing(
        workshops.map { workshop in
          El.Li.containing(
            El.A[Attr.href => "/workshops/\(workshop.workshopId)", Attr.className => "WorkshopsIndexPage__archive__list__item"].containing( 
              workshop.title
            )
          )
        }
      )
    )
  }
}
