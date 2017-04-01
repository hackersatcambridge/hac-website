import Foundation
import Yaml


public struct Workshop {
  let title: String
  let authors: [String]
  let presenters: [String]
  let thanks: [Thanks]
  let recommendations: [Recommendation]
  let links: [URL]
  let tags: [String]
  let prerequisites: Text
  let description: Text

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
}

public extension Workshop {
  enum WorkshopError: Error {
    case malformedMetadata(String)
  }
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
    let prerequisites = Text(markdown: prerequisitesMarkdown)
    let description = Text(markdown: descriptionMarkdown)

    // Process the Yaml
    return Workshop(
      title: try title(from: metadata),
      authors: try authors(from: metadata),
      presenters: try presenters(from: metadata),
      thanks: try thanks(from: metadata),
      recommendations: try recommendations(from: metadata),
      links: try links(from: metadata),
      tags: try tags(from: metadata),
      prerequisites: prerequisites,
      description: description
    )
  }

  private static func title(from metadata: Yaml) throws -> String {
    if let title = metadata["title"].string {
      return title
    } else {
      throw WorkshopError.malformedMetadata("Missing or invalid title")
    }
  }

  private static func stringsArray(for key: Yaml, in metadata: Yaml) throws -> [String] {
    guard let values = metadata[key].array else {
      throw WorkshopError.malformedMetadata("Missing \(key) list")
    }
    return try values.map({
      if let stringValue = $0.string {
        return stringValue
      } else {
        throw WorkshopError.malformedMetadata("Expected values in \(key) to be strings")
      }
    })
  }

  private static func authors(from metadata: Yaml) throws -> [String] {
    return try stringsArray(for: "authors", in: metadata)
  }

  private static func presenters(from metadata: Yaml) throws -> [String] {
    return try stringsArray(for: "presenters", in: metadata)
  }

  private static func thanks(from metadata: Yaml) throws -> [Workshop.Thanks] {
    guard let values = metadata["thanks"].array else {
      return []
    }
    return try values.map { 
      guard let recipient = $0["to"].string else {
        throw WorkshopError.malformedMetadata("Expected all thanks items to contain 'to' property")
      }
      let reason = $0["reason"].string
      return Workshop.Thanks(to: recipient, reason: reason)
    }
  }

  private static func recommendations(from metadata: Yaml) throws -> [Workshop.Recommendation] {
    guard let values = metadata["recommend"].array else {
      return []
    }
    return try values.map { 
      guard let title = $0["name"].string else {
        throw WorkshopError.malformedMetadata("Expected all recommendations items to contain 'name' property")
      }
      guard 
        let urlString = $0["url"].string,
        let url = URL(string: urlString)
      else {
        throw WorkshopError.malformedMetadata("Expected all recommendations items to contain valid URLs in 'url' property")
      }
      return Workshop.Recommendation(title: title, url: url)
    }
  }

  private static func links(from metadata: Yaml) throws -> [URL] {
    return try stringsArray(for: "links", in: metadata).map {
      if let url = URL(string: $0) {
        return url
      } else {
        throw WorkshopError.malformedMetadata("Expected all links to be valid URLs (see \($0))")
      }
    }
  }

  private static func tags(from metadata: Yaml) throws -> [String] {
    return try stringsArray(for: "tags", in: metadata)
  }

}