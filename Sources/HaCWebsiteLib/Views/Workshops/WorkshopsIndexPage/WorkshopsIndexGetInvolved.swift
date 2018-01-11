import HaCTML

/// A section that encourages people to get involved in producing workshops
struct WorkshopsIndexGetInvolved: Nodeable {
  var node: Node {
    return El.Div[Attr.className => "WorkshopsIndexPage__getInvolved WorkshopsIndexGetInvolved"].containing(
      getInvolvedIntro,
      getInvolvedRoles,
      getInvolvedCallToAction
    )
  }

  private var getInvolvedIntro: Node {
    return El.Div[Attr.className => "WorkshopsIndexGetInvolved__intro"].containing(
      El.H2[Attr.className => "Text--headline"].containing("Behind the Scenes"),
      Markdown("""
        Hackers at Cambridge workshops are developed by the community.
        Behind every workshop is a team of people who have committed their time to making it the best it can be.
      """)
    )
  }

  private var getInvolvedRoles: Node {
    return El.Div[Attr.className => "WorkshopsIndexGetInvolved__roles WorkshopsIndexGetInvolvedRoles"].containing(
      El.Div[Attr.className => "WorkshopsIndexGetInvolvedRoles__role WorkshopsIndexGetInvolvedRole"].containing(
        El.Div[Attr.className => "WorkshopsIndexGetInvolvedRole__contentCard"].containing(
          El.H2[Attr.className => "Text--sectionHeading"].containing("Presenter"),
          Markdown("""
            The presenter leads the production of the content for the workshop
            and is the person in the spotlight on the day of the workshop.
          """)
        )
      ),
      El.Div[Attr.className => "WorkshopsIndexGetInvolvedRoles__role WorkshopsIndexGetInvolvedRole"].containing(
        El.Div[Attr.className => "WorkshopsIndexGetInvolvedRole__contentCard"].containing(
          El.H2[Attr.className => "Text--sectionHeading"].containing("Editor"),
          Markdown("""
            The editor is the primary source of feedback on the workshop content.
            They work closely with the presenter to make sure the workshop is polished, clear, and appropriate for the target audience
          """)
        )
      ),
      El.Div[Attr.className => "WorkshopsIndexGetInvolvedRoles__role WorkshopsIndexGetInvolvedRole"].containing(
        El.Div[Attr.className => "WorkshopsIndexGetInvolvedRole__contentCard"].containing(
          El.H2[Attr.className => "Text--sectionHeading"].containing("Organiser"),
          Markdown("""
            The organiser is the person that coordinates with departments, venues, graphics designers and web developers
            to make sure that the audience knows about the workshop and that we have a place to run it.
          """)
        )
      ),
      El.Div[Attr.className => "WorkshopsIndexGetInvolvedRoles__role WorkshopsIndexGetInvolvedRole"].containing(
        El.Div[Attr.className => "WorkshopsIndexGetInvolvedRole__contentCard"].containing(
          El.H2[Attr.className => "Text--sectionHeading"].containing("Demonstrators"),
          Markdown("""
            Demonstrators are people who develop an understanding of the content before the workshop and come along to offer
            in-person help to the attendees.
            The presence of demonstrators at workshops is something that really sets this format apart from lectures or textbooks.
          """)
        )
      ),
      El.Div[Attr.className => "WorkshopsIndexGetInvolvedRoles__role WorkshopsIndexGetInvolvedRole"].containing(
        El.Div[Attr.className => "WorkshopsIndexGetInvolvedRole__contentCard"].containing(
          El.H2[Attr.className => "Text--sectionHeading"].containing("Focus Group"),
          Markdown("""
            Focus Groups are small groups that volunteer to provide early feedback on the workshop.
            The focus group don't necessarily have prior knowledge of the topic. This really puts the presenter's explanations to the test
            and helps to make the content clearer for the target audience.
          """)
        )
      )
    )
  }

  private var getInvolvedCallToAction: Node {
    return El.Div[Attr.className => "WorkshopsIndexGetInvolved__callToAction"].containing(
      El.H2[Attr.className => "Text--headline"].containing("Get Involved"),
      Markdown("""
        Getting involved in workshopping is a great motivation to learn new topics and 
        a rewarding way to improve your teaching, writing and public speaking skills. 

        We love talking to new people about this so if you're interested in getting involved or would like to learn more, don't hesitate to get in touch
      """),
      El.A[Attr.href => "https://m.me/hackersatcambridge", Attr.className => "BigButton BigButton--facebook BigButton--inline"].containing("Message us on Facebook"),
      "or email us at team@hackersatcambridge.com"
    )
  }
}