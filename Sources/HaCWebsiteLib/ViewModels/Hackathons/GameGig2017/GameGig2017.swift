import HaCTML
import Foundation

// swiftlint:disable line_length


extension String {
  func idMangle() -> String {
    return self.replacingOccurrences(of: " ", with: "-").lowercased()
  }
}

// TODO: investigate if the information here can be extracted from the landing feature
struct GameGig2017: Hackathon {
  let gameEngines = [
    ("Unreal Engine", "https://www.unrealengine.com"),
    ("Unity", "https://unity3d.com/"),
    ("LÖVE", "https://love2d.org/"),
    ("GameMaker", "lhttps://www.yoyogames.com/gamemaker"),
    ("raylib", "http://www.raylib.com/")
  ]

  let socialMediaLinks = [
    ("Facebook Page", "https://www.facebook.com/hackersatcambridge"),
    ("Facebook Event", "https://www.facebook.com/events/124219834921040/"),
    ("Twitter", "https://twitter.com/hackersatcam")
  ]

  let tutorials = [
    ("Web Dev with Mozilla", "https://globalgamejam.org/news/dev-web-mozilla")
  ]

  /**
   * Creates a GameGigCard element, the title becomes its id (spaces are replaced with hyphons)
   */
  func GameGigCard(title: String, content: Nodeable) -> Node {
    return El.Div[Attr.className => "GameGigCard"].containing(
      El.Span[
        Attr.className => "GameGigCard__title",
        Attr.id => title.idMangle()
      ].containing(title),
      content
    )
  }

  func ListOfLinks(dict: [(String, String)]) -> Nodeable {
    return El.Ul.containing(
      dict.map { (key, value) in
        El.Li.containing(
          El.A[Attr.href => value].containing(key)
        )
      }
    )
  }

  func GameGigTwitterFeed() -> Nodeable {
    return El.Div[Attr.className => "GameGigTwitterFeed"].containing(
      TextNode(
        "<a class=\"twitter-timeline\" data-dnt=\"true\" href=\"https://twitter.com/hashtag/hacgamegig\" data-widget-id=\"927201930149093377\">#hacgamegig Tweets</a><script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+\"://platform.twitter.com/widgets.js\";fjs.parentNode.insertBefore(js,fjs);}}(document,\"script\",\"twitter-wjs\");</script>",
        escapeLevel: .unsafeRaw
      )
    )
  }

  func Rules() -> Nodeable {
    return Markdown("""
      The aim of the Hackers at Cambridge Game Gig 3000 is to create a fun,
      exciting, original game from scratch in less than 12 hours.
      We've created a few simple rules to help the process go smoothly for
      everyone.

      - **Please note that Computer Science applicants for the University of
        Cambridge are taking CSAT tests in LT1 and LT2, so please be quiet
        around them. This is especially important between the hours of
        10:00-12:00 and 15:00-17:00 when the actual tests will be taking place.
        DO NOT TAKE THEIR REFRESHMENTS, WE HAVE OURS IN FW11.**

      - Also respect and look after the Intel Lab, FW11 and the Computer Lab.
        Note that food or drink may only be consumed in FW11, and we will be
        checking!

      - You can work on your game in a team of up to four people.

      - Game-making commences at 10:30 and finishes at 20:00.

      - You are free to do whatever you like with your game after the Game Gig.
        You own the copyright to all the material you create during the event.

      - You are free to use any tools or libraries available to you to create
        your game. You can start with any pre-existing code or content that you
        like and you are free to use third-party assets, as long as you let the
        judges know what you created yourself and what you didn't. Failure to do
        so could risk disqualification.

      - It's your responsibility to make sure that you have the right to use
        third-party assets (for example, that they are public domain or
        available under an appropriate license).

      - We will be taking lots of photos throughout the event, and publishing
        them. You and your content may appear on some of these photos. We aim to
        publish photos that show everyone at their best, but there might be a
        few that you don’t like. If you see a photo like this, let us know so
        that we can try to take it down - but be aware that it is difficult to
        completely erase a photo from all media channels.

      - Be kind and considerate to your fellow hackers and our volunteers.
        We're all here to have fun! By participating in the hackathon, you agree
        to abide by this [Code of Conduct](https://hackcodeofconduct.org/).
      """
    )
  }

  func GameGigCardsContainer(content: Nodeable) -> Node {
    return El.Div[Attr.className => "GameGigCardsContainer"].containing(
      content
    )
  }

  func NavBar(elements: [(String, Nodeable)]) -> Node {
    return El.Div[Attr.className => "GameGigNavBar"].containing(
      El.Span[Attr.className => "GameGigNavBar__poweredby"].containing(
        "Powered by ",
        El.A[Attr.href => "http://studiogobo.com/",
             Attr.target => "_blank"
        ].containing(
          El.Img[
            Attr.src => "/static/images/sponsors/studiogobo-logo.svg",
            Attr.alt => "Studio Gobo"
          ]
        ),
        " and ",
        El.A[Attr.href => "https://www.electricsquare.com/",
             Attr.target => "_blank"
        ].containing(
          El.Img[
            Attr.src => "/static/images/sponsors/electricsquare-logo.svg",
            Attr.alt => "Electric Square"
          ]
        )
      ),
      Fragment(elements.map{ title, content in
        El.Span[Attr.className => "GameGigNavBar__item"].containing(
          El.A[
            Attr.href => "#\(title.idMangle())"
          ].containing(
            title
          )
        )
      }),
      El.Span[Attr.className => "GameGigNavBar__time"].containing(CurrentTime())
    )
  }

  // Convert a given time in String format, (eg. "12:00"), to the corresponding
  // Swift Date object representing that time on the day of the event itself
  let eventDate = Date.from(year: 2017, month: 12, day: 1, hour: 0, minute: 0)
  func gameGigDate(_ time: String) -> Date {
      // To the dirty work by converting the events date to a string, appending the time, and convertin to a date again
      let outFormatter = DateFormatter()
      outFormatter.dateFormat = "yyyy-MM-dd"
      outFormatter.timeZone = TimeZone(identifier: "Europe/London")
      outFormatter.locale = Locale(identifier: "en_GB")

      let dateTimeString = outFormatter.string(from: eventDate) + " " + time

      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd HH:mm"
      formatter.timeZone = TimeZone(identifier: "Europe/London")
      formatter.locale = Locale(identifier: "en_GB")
      let dateTime = formatter.date(from: dateTimeString)
      return dateTime ?? Date()
  }

  var node: Node {
    // Define all  time related info
    let gigStartDate = gameGigDate("10:30")
    let gigEndDate = gameGigDate("20:30")


    let schedule = [
      ("Arrival", gameGigDate("10:00")),
      ("Start Jamming!", gigStartDate),
      ("Lunch", gameGigDate("12:00")),
      ("Dinner", gameGigDate("18:00")),
      ("Stop Jamming!", gigEndDate),
      ("LT1 Prizes and wrap-up", gameGigDate("21:00"))
    ]

    // Define the list of game gig "cards" that are displayed as content
    let gameGigCards = [
      ("Schedule", Schedule(schedule: schedule)),
      ("Get Involved", ListOfLinks(dict: socialMediaLinks)),
      ("Tutorials", ListOfLinks(dict: tutorials)),
      ("Game Engines", ListOfLinks(dict: gameEngines)),
      //("Feed", GameGigTwitterFeed()),
      ("Rules", Rules())
    ]

    return UI.Pages.base(
      title: "Hackers at Cambridge Game Gig 80's",
      customStylesheets: ["gamegig2017"],
      content: Fragment(
        NavBar(elements: gameGigCards),
        El.Div[Attr.className => "GameGigTopBar"].containing(
          El.Img[Attr.src => "/static/images/gamegig3000-logo.png"],
          CountDownTimer(startDate: gigStartDate, endDate: gigEndDate)
        ),
        GameGigCardsContainer(content: Fragment(
          gameGigCards.map{ title, content in
            GameGigCard(title: title, content: content)
          }
        ))
      )
    )
  }
}
