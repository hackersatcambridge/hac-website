import HaCTML

// swiftlint:disable line_length

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

  let schedule = [
    ("10:00", "Arrival"),
    ("10:30", "Start Jamming!"),
    ("12:00", "Lunch"),
    ("18:00", "Dinner"),
    ("20:00", "Stop Jamming!"),
    ("21:00", "LT1 Prizes and wrap-up")
  ]

  func GameGigCard(title: String, content: Nodeable) -> Node {
    return El.Div[Attr.className => "GameGigCard"].containing(
      El.Span[Attr.className => "GameGigCard_Title"].containing(title),
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

  func TwitterFeed() -> Nodeable {
    return El.P.containing(
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
      El.Div[Attr.className => "GameGigTopBanner_Left"].containing("Hackers at Cambridge Game Gig 80's"),
      El.Div[Attr.className => "GameGigTopBanner_Center"].containing("Powered by Studio Gobo and Electric Square"),
      El.Div[Attr.className => "GameGigTopBanner_Right"].containing(CurrentTime())
    )
  }

  var node: Node {
    return UI.Pages.base(
      title: "Hackers at Cambridge Game Gig 80's",
      customStylesheets: ["gamegig2017"],
      content: Fragment(
        GameGigTopBanner(),
        CountDownTimer().node,
        GameGigCardsContainer(content: Fragment(
          GameGigCard(title: "Schedule", content: Schedule(schedule: schedule)),
          GameGigCard(title: "Feed", content: TwitterFeed()),
          GameGigCard(title: "Get Involved", content: ListOfLinks(dict: socialMediaLinks)),
          GameGigCard(title: "Game Engines", content: ListOfLinks(dict: gameEngines)),
          GameGigCard(title: "Tutorials", content: ListOfLinks(dict: tutorials)),
          GameGigCard(title: "Rules", content: Rules())
        ))
      )
    )
  }
}
