import HaCTML

/// Above-the-fold for the WorkshopsIndexPage
struct WorkshopsIndexSchedule: Nodeable {
  var node: Node {
    return El.Div[Attr.className => "WorkshopsIndexPage__schedule WorkshopsIndexSchedule"].containing(
      feature,
      upcoming
    )
  }

  var feature: Node {
    return El.Section[Attr.className => "WorkshopsIndexFeature WorkshopsIndexSchedule__feature"].containing(
      El.H1[Attr.className => "Text--sectionHeading"].containing("Featured"),
      El.Div[Attr.className => "WorkshopsIndexFeature__hero"].containing(LandingFeatures.programmingInRust)
    )
  }

  var upcoming: Node {
    return El.Div[Attr.className => "WorkshopsIndexSchedule__upcoming WorkshopsIndexUpcoming"].containing(
      El.Div[Attr.className => "WorkshopsIndexUpcoming__list"].containing(
        El.A[Attr.href => "#", Attr.className => "WorkshopsIndexUpcomingWorkshop"].containing(
          El.Span[Attr.className => "WorkshopsIndexUpcomingWorkshop__date"].containing(
            "23 Jan"
          ),
          El.Span[Attr.className => "WorkshopsIndexUpcomingWorkshop__title"].containing(
            "Intro to Swift"
          )
        ),
        El.A[Attr.href => "#", Attr.className => "WorkshopsIndexUpcomingWorkshop"].containing(
          El.Span[Attr.className => "WorkshopsIndexUpcomingWorkshop__date"].containing(
            "1 Feb"
          ),
          El.Span[Attr.className => "WorkshopsIndexUpcomingWorkshop__title"].containing(
            "Command Line Tools"
          )
        ),
        El.A[Attr.href => "#", Attr.className => "WorkshopsIndexUpcomingWorkshop"].containing(
          El.Span[Attr.className => "WorkshopsIndexUpcomingWorkshop__date"].containing(
            "10 Feb"
          ),
          El.Span[Attr.className => "WorkshopsIndexUpcomingWorkshop__title"].containing(
            "Machine Learning with TensorFlow"
          )
        )
      )
    )
  }
}