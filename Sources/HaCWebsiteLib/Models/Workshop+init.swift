import Foundation
import Yaml

private let filePaths = (
  metadata: "/.hac_workshop/metadata.yaml",
  description: "/.hac_workshop/description.md",
  prerequisites: "/.hac_workshop/prerequisites.md",
  promoImagesDirectory: "/.hac_workshop/promo_images",
  notesMarkdown: "/.hac_workshop/notes.md",
  examplesDirectory: "/",
  presenterGuide: "/.hac_workshop/presenter_guide.md",
  setupInstructions: "/.hac_workshop/setup_instructions.md"
)

private let validImageExtensions = ["jpg", "svg", "png", "gif"]

extension Workshop {
  /// Create a Workshop from a local path
  init(localPath: String, headCommitSha: String) throws {
    workshopId = try Workshop.getWorkshopId(localPath: localPath)
    let metadata = try Workshop.getMetadata(localPath: localPath)
    let builder = WorkshopBuilder(localPath: localPath, commitSha: headCommitSha, workshopId: workshopId, metadata: metadata)

    presenterGuide = try builder.getPresenterGuide()
    promoImageBackground = try builder.getPromoImageBackground()
    promoImageForeground = try builder.getPromoImageForeground().absoluteString
    description = try builder.getDescription()
    prerequisites = try builder.getPrerequisites()
    setupInstructions = try builder.getSetupInstructions()

    examplesLink = try builder.getExamplesLink()
    notes = try builder.getNotes()

    title = try builder.getTitle()
    contributors = try builder.getContributors()
    thanks = try builder.getThanks()
    furtherReadingLinks = try builder.getFurtherReadingLinks()
    recordingLink = try builder.getRecordingLink()
    slidesLink = try builder.getSlidesLink()
    tags = try builder.getTags()
    license = try builder.getLicense()
  }

  private static func getWorkshopId(localPath: String) throws -> String {
    let directoryName = localPath.components(separatedBy: "/").last ?? localPath

    if directoryName.hasPrefix("workshop-") {
      return String(directoryName.dropFirst("workshop-".count))
    } else {
      throw WorkshopError.invalidPath
    }
  }

  private static func getMetadata(localPath: String) throws -> Yaml {
    let metadataString: String
    do {
      metadataString = try String(contentsOfFile: localPath + filePaths.metadata, encoding: .utf8)
    } catch {
      throw WorkshopError.missingMetadata
    }
    return try Yaml.load(metadataString)
  }
}

private enum WorkshopError: Swift.Error {
  case invalidPath
  case missingMetadata
  case malformedMetadata(String)
  case missingPromoImageBackground
  case missingPromoImageForeground
  case missingMetadataKey(String)
  case multiplePromoImageForegrounds
  case multiplePromoImageBackgrounds
  case invalidPromoImageForegroundFormat
  case invalidPromoImageBackgroundFormat
  case missingMarkdown(String)
  case badURLInNotes(String)
  case emptyExamples
  case invalidURL(String)
}

private struct WorkshopBuilder {
  let localPath: String
  let commitSha: String
  let workshopId: String
  let metadata: Yaml

  func getMarkdown(relativePath: String) throws -> Markdown {
    do {
      let markdown = try Markdown(contentsOfFile: localPath + relativePath)
      return markdown.resolvingRelativeURLs(relativeTo: try fileServingUrl(relativePath: relativePath))
    } catch {
      throw WorkshopError.missingMarkdown(relativePath)
    }
  }

  func getDescription() throws -> Markdown {
    return try getMarkdown(relativePath: filePaths.description)
  }

  func getPrerequisites() throws -> Markdown {
    return try getMarkdown(relativePath: filePaths.prerequisites)
  }

  func getSetupInstructions() throws -> Markdown {
    return try getMarkdown(relativePath: filePaths.setupInstructions)
  }

  func getPresenterGuide() throws -> Markdown? {
    return try? getMarkdown(relativePath: filePaths.presenterGuide)
  }

  func getNotes() throws -> Markdown {
    return try getMarkdown(relativePath: filePaths.notesMarkdown)
  }

  private func repoUrl(origin: String, relativePath: String) throws -> URL {
    let urlString = "\(origin)hackersatcambridge/workshop-\(workshopId)/\(relativePath)"

    if let url = URL(string: urlString) {
      return url
    } else {
      throw WorkshopError.invalidURL(urlString)
    }
  }

  func fileServingUrl(relativePath: String) throws -> URL {
    return try repoUrl(origin: "https://rawgit.com/", relativePath: "\(commitSha)\(relativePath)")
  }

  func remoteRepoUrl(relativePath: String) throws -> URL {
    return try repoUrl(origin: "https://github.com/", relativePath: "tree/master\(relativePath)");
  }

  /// Return the CDN url of the foreground of the promotional image
  func getPromoImageForeground() throws -> URL {
    let promoImageFileNames = try FileManager.default.contentsOfDirectory(atPath: localPath + filePaths.promoImagesDirectory)
    let foregroundImageFileNames = promoImageFileNames.filter { $0.hasPrefix("fg.") }

    guard foregroundImageFileNames.count == 1 else {
      if foregroundImageFileNames.count < 1 {
        throw WorkshopError.missingPromoImageForeground
      } else {
        throw WorkshopError.multiplePromoImageForegrounds
      }
    }

    let foregroundImageFileName = foregroundImageFileNames[0]

    guard validImageExtensions.contains(getFileExtension(fromPath: foregroundImageFileName) ?? "") else {
      throw WorkshopError.invalidPromoImageForegroundFormat
    }

    let relativePathFromRepo = filePaths.promoImagesDirectory + "/" + foregroundImageFileName
    return try fileServingUrl(relativePath: relativePathFromRepo)
  }

  /// The `Background` of the promotional image
  func getPromoImageBackground() throws -> Background {
    let promoImageFileNames = try FileManager.default.contentsOfDirectory(atPath: localPath + filePaths.promoImagesDirectory)
    let backgroundFileNames = promoImageFileNames.filter { $0.hasPrefix("bg.") }
    guard backgroundFileNames.count == 1 else {
      if backgroundFileNames.count < 1 {
        throw WorkshopError.missingPromoImageBackground
      } else {
        throw WorkshopError.multiplePromoImageBackgrounds 
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
      return Background.image(try fileServingUrl(relativePath: relativePathFromRepo).absoluteString)
    } else {
      throw WorkshopError.invalidPromoImageBackgroundFormat
    }
  }

  func getExamplesLink() throws -> URL? {
    let examplesPath = localPath + filePaths.examplesDirectory

    // If there are non-hidden directories in the examples path, link to it
    if try FileManager.default.contentsOfDirectory(atPath: examplesPath).contains { !$0.starts(with: ".") } {
      return try remoteRepoUrl(relativePath: filePaths.examplesDirectory)
    } else {
      return nil
    }
  }

  func getTitle() throws -> String {
    if let title = metadata["title"].string {
      return title
    } else {
      throw WorkshopError.malformedMetadata("Missing title")
    }
  }

  func getContributors() throws -> [String] {
    return try stringsArray(for: "contributors", in: metadata)
  }

  func getThanks() throws -> [String] {
    do {
      return try stringsArray(for: "thanks", in: metadata)
    } catch WorkshopError.missingMetadataKey(_) {
      return []
    }
  }

  func getFurtherReadingLinks() throws -> [Link] {
    guard let links = metadata["further_reading_links"].array else {
      return []
    }
    return try links.map({
      guard let text = $0["text"].string,
        let urlString = $0["url"].string else {
        throw WorkshopError.malformedMetadata("Links should have a 'text' and a 'url' property")
      }
      
      guard let url = URL(string: urlString) else {
        throw WorkshopError.malformedMetadata("Links should have valid URLs")
      }

      return Link(text: text, url: url)
    })
  }

  func getRecordingLink() throws -> URL? {
    guard let urlString = metadata["recording_link"].string else {
      return nil
    }
    
    guard let url = URL(string: urlString) else {
      throw WorkshopError.malformedMetadata("Recording link should be a valid URL")
    }

    return url
  }

  func getSlidesLink() throws -> URL? {
    guard let urlString = metadata["slides_link"].string else {
      return nil
    }
    
    guard let url = URL(string: urlString, relativeTo: try fileServingUrl(relativePath: filePaths.metadata)) else {
      throw WorkshopError.malformedMetadata("Slides link should be a valid URL")
    }

    return url
  }

  func getTags() throws -> [String] {
    return try stringsArray(for: "tags", in: metadata)
  }

  func getLicense() throws -> String {
    if let license = metadata["license"].string {
      return license
    } else {
      throw WorkshopError.malformedMetadata("Missing license")
    }
  }
}

/// Get the extension of a file. Returns nil if no file extension is present
private func getFileExtension(fromPath filePath: String) -> String? {
  if filePath.contains(".") {
    return filePath.components(separatedBy: ".").last
  } else {
    return nil
  }
}

private func stringsArray(for key: Yaml, in metadata: Yaml) throws -> [String] {
  guard let values = metadata[key].array else {
    throw WorkshopError.missingMetadataKey("Missing \(key) list")
  }

  return try values.map({
    if let stringValue = $0.string {
      return stringValue
    } else {
      throw WorkshopError.malformedMetadata("Expected values in \(key) to be strings")
    }
  })
}
