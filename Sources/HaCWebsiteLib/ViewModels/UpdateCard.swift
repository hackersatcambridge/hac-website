import HaCTML

struct UpdateCard {
  enum UpdateCategory: String {
    case workshop = "Workshop"
    case video = "Video"
    case hackathon = "Hackathon"
  }

  let title: String
  let category: UpdateCategory
  let description: String
  let backgroundColor: String?
  let imageURL: String?
  
  var node: Node {
    return El.Div[Attr.className => "PostCard", Attr.style => ["background-color": backgroundColor]].containing(
      El.Div[
        Attr.className => "PostCard__photoBackground",
        Attr.style => ["background-image": {
            if let imageURL = imageURL {
              return "url('\(imageURL)')"
            } else {
              return nil
            }
          }()
        ]
      ],
      El.Div[Attr.className => "PostCard__content"].containing(
        El.Span[Attr.className => "PostCard__categoryLabel"].containing(category.rawValue),
        El.Div[Attr.className => "PostCard__title"].containing(title),
        El.Div[Attr.className => "PostCard__description"].containing(description),
        El.Div[Attr.className => "PostCard__bottomAction"].containing("Find out more")
      )
    )
  }
}