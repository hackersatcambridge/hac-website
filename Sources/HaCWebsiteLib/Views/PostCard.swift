import HaCTML

struct PostCard: Nodeable {
  enum PostCategory: String {
    case workshop = "Workshop"
    case video = "Video"
    case hackathon = "Hackathon"
    case general = "General Event"
  }

  let title: String
  let category: PostCategory
  let description: String
  let backgroundColor: String?
  let imageURL: String?

  init(
    title: String, category: PostCategory,
    description: String,
    backgroundColor: String?, imageURL: String? = nil
  ) {
    self.title = title
    self.category = category
    self.description = description
    self.backgroundColor = backgroundColor
    self.imageURL = imageURL
  }

  var node: Node {
    return El.Div[Attr.className => "PostCard", Attr.style => ["background-color": backgroundColor]].containing(
      El.Div[
        Attr.className => "PostCard__photoBackground",
        Attr.style => ["background-image": imageURL.map { "url('\($0)')" }]
      ],
      El.Div[Attr.className => "PostCard__content"].containing(
        El.Span[Attr.className => "PostCard__categoryLabel"].containing(category.rawValue),
        El.Div[Attr.className => "PostCard__title"].containing(title),
        El.Div[Attr.className => "PostCard__description"].containing(description)
      ),
      El.Div[Attr.className => "PostCard__footer"].containing(
        El.Div[Attr.className => "PostCard__bottomAction"].containing("Find out more")
      )
    )
  }
}

protocol PostCardRepresentable {
  var postCardRepresentation : PostCard {get}
}