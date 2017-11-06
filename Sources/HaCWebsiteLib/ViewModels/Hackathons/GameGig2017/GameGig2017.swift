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

  // TODO: grab the rulse from the constitution Repo
  func Rules() -> Nodeable {
    return Fragment(
      El.P.containing("The aim of the Game Gig is to create a fun, exciting, original game from scratch in less than 12 hours. We've created a few simple rules to help the process go smoothly for everyone."),
      El.Ul.containing(
        El.Li.containing("Please respect and look after the Computer Lab. Note that no food or drinks are permitted in the Intel Laboratory, and we will be checking"),
        El.Li.containing("You can work on your game in a team of up to four people."),
        El.Li.containing("Game-making commences at 10:30 and finishes at 20:00."),
        El.Li.containing("You are free to do whatever you like with your game after the Game Gig. You own the copyright to all the material you create during the Game Gig."),
        El.Li.containing("You are free to use any tools or libraries available to you to create your game. You can start with any pre-existing code or content that you like and you are free to use third-party assets, as long as you let the judges know what you created yourself and what you didn't. Failure to do so could risk disqualification."),
        El.Li.containing("It's your responsibility to make sure that you have the right to use third-party assets (for example, that they are public domain or available under an appropriate license)."),
        El.Li.containing(TextNode(
          Text(markdown: "Be kind and considerate to your fellow hackers and our volunteers. We're all here to have fun! By participating in the hackathon, you agree to abide by this [Code of Conduct](https://hackcodeofconduct.org/).").html,
          escapeLevel: .unsafeRaw
        ))
      )
    )
  }

  func GameGigCardsContainer(content: Nodeable) -> Node {
    return El.Div[Attr.className => "GameGigCardsContainer"].containing(
      content
    )
  }

  func GameGigTopBanner() -> Node {
    return El.Div[Attr.className => "GameGigTopBanner"].containing(
      El.Div[Attr.className => "GameGigTopBanner__right"].containing(CurrentTime()),
      El.Div[Attr.className => "GameGigTopBanner__left"].containing("Hackers at Cambridge Game Gig 80's")
    )
  }

  func NavBar(elements: [(String, Nodeable)]) -> Node {
    return El.Div[Attr.className => "GameGigNavBar"].containing(
      El.Span[Attr.className => "GameGigNavBar__logo"].containing("Powered by Studio Gobo and Electric Square"),
      Fragment(elements.map{ title, content in
        El.Span[Attr.className => "GameGigNavBar__item"].containing(
          El.A[
            Attr.href => "#\(title.idMangle())"
          ].containing(
            title
          )
        )
      })
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
      ("Feed", GameGigTwitterFeed()),
      ("Get Involved", ListOfLinks(dict: socialMediaLinks)),
      ("Game Engines", ListOfLinks(dict: gameEngines)),
      ("Tutorials", ListOfLinks(dict: tutorials)),
      ("Rules", Rules())
    ]

    return UI.Pages.base(
      title: "Hackers at Cambridge Game Gig 80's",
      customStylesheets: ["gamegig2017"],
      content: Fragment(
        GameGigTopBanner(),
        NavBar(elements: gameGigCards),
        CountDownTimer(startDate: gigStartDate, endDate: gigEndDate),
        GameGigCardsContainer(content: Fragment(
          gameGigCards.map{ title, content in
            GameGigCard(title: title, content: content)
          }
        ))
      )
    )
  }
}
