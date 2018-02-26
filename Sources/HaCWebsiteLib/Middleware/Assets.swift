import Kitura
import SwiftyJSON
import Foundation

/**
  Utilities for accessing public assets for the website
 */
enum Assets {
  /**
    Location of manifest mapping logical file names to real locations (open it for an example)
   */
  static private let manifestPath = "./static/dist/manifest.json"

  /**
    Middleware serving all of our public assets. Where this is mounted on must be kept in
    sync with `config.urlBase`
   */
  static public let fileServingMiddleware = StaticFileServer(path: "./static/dist")

  static private var resolver: AssetResolver? = nil
  static private var config: AssetsConfig? = nil

  private static func resolveAssetPath(_ assetPath: String) -> String {
    if (self.resolver == nil) || (!Config.isProduction)  {
      self.resolver = AssetResolver(manifestPath: manifestPath)
    }

    if let resolver = self.resolver {
      return resolver.publicPath(assetPath)
    }
    
    fatalError("Could not create AssetResolver")
  }

  /**
    Initialize with configuration. This must be done exactly once before using the public API
   */
  public static func initialize(config: AssetsConfig) {
    precondition(self.config == nil)

    self.config = config
  }

  /**
    Get the path for publicly accessing a static asset.

    This is to abstract away how we as programmers identify assets (files we write to)
    from how our web browsers will. Files may have names changed, and we may even be serving
    assets from a CDN (a different domain).

    Asset paths must be relative to the distribution directory of built assets in this project
   */
  static func publicPath(_ assetPath: String) -> String {
    return config!.urlBase + "/" + resolveAssetPath(assetPath)
  }

  struct AssetsConfig {
    /**
      Where assets are served relative to on our website
     */
    public let urlBase: String
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
    return String(string[string.index(after: string.startIndex)...])
  }

  return string
}
