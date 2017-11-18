import Kitura
import SwiftyJSON
import Foundation

enum Assets {
  static private let filesystemPath = "./static/dist"
  static private let manifestPath = filesystemPath + "/manifest.json"
  static private let urlPath = "/static"
  static private var resolver: AssetResolver? = nil

  private static func resolveAssetPath(_ assetPath: String) -> String {
    if (self.resolver == nil) || (!Config.isProduction)  {
      self.resolver = AssetResolver(manifestPath: manifestPath)
    }

    if let resolver = self.resolver {
      return resolver.publicPath(assetPath)
    }
    
    fatalError("Could not create AssetResolver")
  }

  static func publicPath(_ assetPath: String) -> String {
    return urlPath + "/" + resolveAssetPath(assetPath)
  }

  static func addTo(router: Router) {
    router.all(urlPath, middleware: StaticFileServer(path: filesystemPath))
  }
}

private struct AssetResolver {
  let manifest: JSON

  init?(manifestPath: String) {
    if let manifestFile = try? String(contentsOfFile: manifestPath, encoding: .utf8),
       let manifestData = manifestFile.data(using: .utf8, allowLossyConversion: false) {
      manifest = JSON(data: manifestData)
    } else {
      return nil
    }
  }

  func publicPath(_ assetPath: String) -> String {
    if let publicPath = manifest[omitLeadingSlash(assetPath)].string {
      return publicPath
    }

    fatalError("Asset not found: \(assetPath)")
  }
}

private func omitLeadingSlash(_ string: String) -> String {
  if (string[string.startIndex] == "/") {
    return string.substring(from: string.index(after: string.startIndex))
  }

  return string
}
