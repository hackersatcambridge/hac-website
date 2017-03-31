import Foundation
import Yaml
import KituraMarkdown

public struct Workshop {
  let title: String
  let authors: [String]
  let presenters: [String]
  let thanks: [Thanks]
  let recommendations: [Recommendation]
  let links: [URL]
  let tags: [String]
  let prerequisites: String
  let description: String

  struct Thanks: Equatable {
    let to: String
    let reason: String?

    static func ==(lhs: Workshop.Thanks, rhs: Workshop.Thanks) -> Bool {
      return lhs.to == rhs.to && lhs.reason == rhs.reason
    }
  }

  struct Recommendation: Equatable {
    let title: String
    let url: URL
    
    static func ==(lhs: Workshop.Recommendation, rhs: Workshop.Recommendation) -> Bool { 
      return lhs.title == rhs.title && lhs.url == rhs.url
    }
  }

  enum WorkshopError: Error {
    case malformedMetadata
  }
}

public extension Workshop {
  /**
    Parses the files that describe a workshop into a Workshop instance

    - returns:
      The generated Workshop instance
   
    - parameters:
      - metadataYaml: The String contents of the Yaml metadata for this workshop
      - descriptionMarkdown: The String contents of the Markdown file with the description of this workshop
      - prerequisitesMarkdown: The String contents of the Markdown file with the prerequisites of this workshop
   
    - throws:
      An error of type Workshop.WorkshopError.malformedMetadata if the Yaml file does not follow the expected structure
   
   */
  public static func parse(metadataYaml: String, descriptionMarkdown: String, prerequisitesMarkdown: String) throws -> Workshop {
    // Parse Yaml and Markdown
    let metadata = try Yaml.load(metadataYaml)
    let description = KituraMarkdown.render(from: descriptionMarkdown)
    let prerequisites = KituraMarkdown.render(from: prerequisitesMarkdown)

    // Process the Yaml
    guard
      let title = metadata["title"].string,
      let authors = metadata["authors"].array?.flatMap({ $0.string }), // removes nil results
      let presenters = metadata["presenters"].array?.flatMap({ $0.string }),
      let thanks: [Workshop.Thanks] = metadata["thanks"].array?.flatMap({ 
        guard let recipient = $0["to"].string else {
          return nil
        }
        let reason = $0["reason"].string
        return Workshop.Thanks(to: recipient, reason: reason)
      }),
      let recommendations: [Workshop.Recommendation] = metadata["recommend"].array?.flatMap({ 
        guard
          let title = $0["name"].string,
          let urlString = $0["url"].string,
          let url = URL(string: urlString)
        else {
          return nil
        }
        return Workshop.Recommendation(title: title, url: url)
      }),
      let links = metadata["links"].array?.flatMap({ $0.string }).flatMap({ URL(string: $0) }),
      let tags = metadata["tags"].array?.flatMap({ $0.string })
    else {
      // Something went wrong with processing the metadata
      throw Workshop.WorkshopError.malformedMetadata
    }

    return Workshop(
      title: title,
      authors: authors,
      presenters: presenters,
      thanks: thanks,
      recommendations: recommendations,
      links: links,
      tags: tags,
      prerequisites: prerequisites,
      description: description
    )
  }
}