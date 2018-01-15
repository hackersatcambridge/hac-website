import Foundation
import Yaml

let filePaths = (
  metadata: "/info/metadata.yaml",
  description: "/info/description.md",
  prerequisites: "/info/prerequisites.md",
  promoImagesDirectory: "/info/promo_images",
  notesDirectory: "/content/notes",
  notesMarkdown: "/content/notes/notes.md",
  examplesDirectory: "/examples",
  presenterGuide: "/content/presenter_guide.md",
  setupInstructions: "/info/setup_instructions.md"
)

let validImageExtensions = ["jpg", "svg", "png", "gif"]

extension NewWorkshop {
  enum Error: Swift.Error {
    case invalidPath
    case missingMetadata
    case malformedMetadata(String)
    case missingDescription
    case missingPrerequisites
    case missingPromoImageBackground
    case missingPromoImageForeground
    case multiplePromoImageForegrounds
    case multiplePromoImageBackgrounds
    case invalidPromoImageForegroundFormat
    case invalidPromoImageBackgroundFormat
    case missingNotes
    case badURLInNotes(String)
    case emptyExamples
    case invalidURL(String)
  }

  /// Create a NewWorkshop from a local path
  init(localPath: String) throws {
    workshopId = try NewWorkshop.getWorkshopId(localPath: localPath)
    let remoteRepoUrl = "https://github.com/hackersatcambridge/workshop-" + workshopId

    presenterGuide = try NewWorkshop.getPresenterGuide(localPath: localPath)
    promoImageBackground = try NewWorkshop.getPromoImageBackground(localPath: localPath, workshopId: workshopId)
    promoImageForeground = try NewWorkshop.getPromoImageForeground(localPath: localPath, workshopId: workshopId).absoluteString
    description = try NewWorkshop.getDescription(localPath: localPath)
    prerequisites = try NewWorkshop.getPrerequisites(localPath: localPath)
    setupInstructions = try NewWorkshop.getSetupInstructions(localPath: localPath)

    examplesLink = try NewWorkshop.getExamplesLink(localPath: localPath, remoteRepoUrl: remoteRepoUrl)
    notes = try NewWorkshop.getNotes(localPath: localPath)

    let metadata = try NewWorkshop.getMetadata(localPath: localPath)


    title = try NewWorkshop.getTitle(from: metadata)
    contributors = try NewWorkshop.getContributors(from: metadata)
    thanks = try NewWorkshop.getThanks(from: metadata)
    furtherReadingLinks = try NewWorkshop.getFurtherReadingLinks(from: metadata)
    recordingLink = try NewWorkshop.getRecordingLink(from: metadata)
    slidesLink = try NewWorkshop.getSlidesLink(from: metadata)
    tags = try NewWorkshop.getTags(from: metadata)
    license = try NewWorkshop.getLicense(from: metadata)
  }

  fileprivate static func getWorkshopId(localPath: String) throws -> String {
    let directoryName = localPath.components(separatedBy: "/").last ?? localPath

    if directoryName.hasPrefix("workshop-") {
      return String(directoryName.dropFirst("workshop-".count))
    } else {
      throw Error.invalidPath
    }
  }

  fileprivate static func getMetadata(localPath: String) throws -> Yaml {
    let metadataString: String
    do {
      metadataString = try String(contentsOfFile: localPath + filePaths.metadata, encoding: .utf8)
    } catch {
      throw Error.missingMetadata
    }
    return try Yaml.load(metadataString)
  }

  fileprivate static func getDescription(localPath: String) throws -> Markdown {
    do {
      return try Markdown(contentsOfFile: localPath + filePaths.description)
    } catch {
      throw Error.missingDescription
    }
  }

  fileprivate static func getPrerequisites(localPath: String) throws -> Markdown {
    do {
      return try Markdown(contentsOfFile: localPath + filePaths.prerequisites)
    } catch {
      throw Error.missingPrerequisites
    }
  }

  fileprivate static func getSetupInstructions(localPath: String) throws -> Markdown {
    return try Markdown(contentsOfFile: localPath + filePaths.setupInstructions)
  }

  fileprivate static func getPresenterGuide(localPath: String) throws -> Markdown {
    return try Markdown(contentsOfFile: localPath + filePaths.presenterGuide)
  }

  /// Get the extension of a file. Returns nil if no file extension is present
  fileprivate static func getFileExtension(fromPath filePath: String) -> String? {
    if filePath.contains(".") {
      return filePath.components(separatedBy: ".").last
    } else {
      return nil
    }
  }

  fileprivate static func remoteRepoUrl(workshopId: String, relativePath: String, raw: Bool = false) throws -> URL {
    let urlString = raw ? "https://rawgit.com/hackersatcambridge/workshop-\(workshopId)/master\(relativePath)" :
      "https://github.com/hackersatcambridge/workshop-\(workshopId)/blob/master\(relativePath)"

    if let url = URL(string: urlString) {
      return url
    } else {
      throw Error.invalidURL(urlString)
    }
  }

  /// Return the CDN url of the foreground of the promotional image
  fileprivate static func getPromoImageForeground(localPath: String, workshopId: String) throws -> URL {
    let promoImageFileNames = try FileManager.default.contentsOfDirectory(atPath: localPath + filePaths.promoImagesDirectory)
    let foregroundImageFileNames = promoImageFileNames.filter { $0.hasPrefix("fg.") }

    guard foregroundImageFileNames.count == 1 else {
      if foregroundImageFileNames.count < 1 {
        throw Error.missingPromoImageForeground
      } else {
        throw Error.multiplePromoImageForegrounds
      }
    }

    let foregroundImageFileName = foregroundImageFileNames[0]

    guard validImageExtensions.contains(getFileExtension(fromPath: foregroundImageFileName) ?? "") else {
      throw Error.invalidPromoImageForegroundFormat
    }

    let relativePathFromRepo = filePaths.promoImagesDirectory + "/" + foregroundImageFileName
    return try remoteRepoUrl(workshopId: workshopId, relativePath: relativePathFromRepo, raw: true)
  }

  /// The `Background` of the promotional image
  fileprivate static func getPromoImageBackground(localPath: String, workshopId: String) throws -> Background {
    let promoImageFileNames = try FileManager.default.contentsOfDirectory(atPath: localPath + filePaths.promoImagesDirectory)
    let backgroundFileNames = promoImageFileNames.filter { $0.hasPrefix("bg.") }
    guard backgroundFileNames.count == 1 else {
      if backgroundFileNames.count < 1 {
        throw Error.missingPromoImageBackground
      } else {
        throw Error.multiplePromoImageBackgrounds 
      }
    }
    let backgroundFileName = backgroundFileNames[0]

    let fileExtension = getFileExtension(fromPath: backgroundFileName) ?? ""

    if fileExtension == "color" {
      let fileContents = try String(contentsOfFile: localPath + filePaths.promoImagesDirectory + "/" + backgroundFileName, encoding: .utf8)
      return Background.color(fileContents)
    } else if validImageExtensions.contains(fileExtension) {
      // Get the CDN url of the image
      let relativePathFromRepo = filePaths.promoImagesDirectory + "/" + backgroundFileName
      return Background.image(try remoteRepoUrl(workshopId: workshopId, relativePath: relativePathFromRepo, raw: true).absoluteString)
    } else {
      throw Error.invalidPromoImageBackgroundFormat
    }
  }

  fileprivate static func getExamplesLink(localPath: String, remoteRepoUrl: String) throws -> URL? {
    let examplesPath = localPath + filePaths.examplesDirectory
    if FileManager.default.fileExists(atPath: examplesPath) {
      if try FileManager.default.contentsOfDirectory(atPath: examplesPath) == [] {
        throw Error.emptyExamples
      } else {
        return URL(string: remoteRepoUrl + filePaths.examplesDirectory)
      }
    } else {
      return nil
    }
  }

  fileprivate static func getNotes(localPath: String) throws -> Markdown {
    // TODO(#192): Handle embedded images in notes.md
    do {
      return try Markdown(contentsOfFile: localPath + filePaths.notesMarkdown)
    } catch {
      throw Error.missingNotes
    }
  }

  fileprivate static func getTitle(from metadata: Yaml) throws -> String {
    if let title = metadata["title"].string {
      return title
    } else {
      throw Error.malformedMetadata("Missing title")
    }
  }

  fileprivate static func stringsArray(for key: Yaml, in metadata: Yaml) throws -> [String] {
    guard let values = metadata[key].array else {
      throw Error.malformedMetadata("Missing \(key) list")
    }
    return try values.map({
      if let stringValue = $0.string {
        return stringValue
      } else {
        throw Error.malformedMetadata("Expected values in \(key) to be strings")
      }
    })
  }

  fileprivate static func getContributors(from metadata: Yaml) throws -> [String] {
    return try stringsArray(for: "contributors", in: metadata)
  }

  fileprivate static func getThanks(from metadata: Yaml) throws -> [String] {
    return try stringsArray(for: "thanks", in: metadata)
  }

  fileprivate static func getFurtherReadingLinks(from metadata: Yaml) throws -> [Link] {
    guard let links = metadata["further_reading_links"].array else {
      throw Error.malformedMetadata("Missing further reading links")
    }
    return try links.map({
      guard let text = $0["text"].string,
        let urlString = $0["url"].string else {
        throw Error.malformedMetadata("Links should have a 'text' and a 'url' property")
      }
      
      guard let url = URL(string: urlString) else {
        throw Error.malformedMetadata("Links should have valid URLs")
      }

      return Link(text: text, url: url)
    })
  }

  fileprivate static func getRecordingLink(from metadata: Yaml) throws -> URL? {
    guard let urlString = metadata["recording_link"].string else {
      return nil
    }
    
    guard let url = URL(string: urlString) else {
      throw Error.malformedMetadata("Recording link should be a valid URL")
    }

    return url
  }

  fileprivate static func getSlidesLink(from metadata: Yaml) throws -> URL? {
    guard let urlString = metadata["slides_link"].string else {
      return nil
    }
    
    guard let url = URL(string: urlString) else {
      throw Error.malformedMetadata("Slides link should be a valid URL")
    }

    return url
  }

  fileprivate static func getTags(from metadata: Yaml) throws -> [String] {
    return try stringsArray(for: "tags", in: metadata)
  }

  fileprivate static func getLicense(from metadata: Yaml) throws -> String {
    if let license = metadata["license"].string {
      return license
    } else {
      throw Error.malformedMetadata("Missing license")
    }
  }
}