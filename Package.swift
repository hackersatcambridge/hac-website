// swift-tools-version:4.0
import PackageDescription

let package = Package(
  name: "HaCWebsite",
  products: [
    .library(name: "HaCTML", targets: ["HaCTML"]),
    .library(name: "HaCWebsiteLib", targets: ["HaCWebsiteLib"]),
    .executable(name: "HaCWebsite", targets: ["HaCWebsite"])
  ],
  dependencies: [
    .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "2.0.0")),
    .package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", .upToNextMinor(from: "17.0.0")),
    .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", .upToNextMinor(from: "1.7.1")),
    .package(url: "https://github.com/IBM-Swift/Kitura-Markdown.git", .upToNextMajor(from: "0.9.1")),
    .package(url: "https://github.com/hackersatcambridge/YamlSwift.git", .upToNextMinor(from: "4.0.0")),
    .package(url: "https://github.com/jaredkhan/SwiftDotEnv.git", .upToNextMinor(from: "1.2.0")),
    .package(url: "https://github.com/alexaubry/HTMLString", .upToNextMinor(from: "3.0.0")),
    .package(url: "https://github.com/vapor/fluent.git", .upToNextMinor(from: "2.4.0")),
    .package(url: "https://github.com/vapor-community/postgresql-driver.git", .upToNextMinor(from: "2.1.0"))
  ],
  targets: [
    .target(name: "HaCTML", dependencies: [
      "HTMLString"
    ]),
    .target(name: "HaCWebsiteLib", dependencies: [
      "HaCTML",
      "Kitura",
      "SwiftyJSON",
      "HeliumLogger",
      "KituraMarkdown",
      "Yaml",
      "SwiftDotEnv",
      "HTMLString",
      "Fluent",
      "PostgreSQLDriver"
    ]),
    .target(name: "HaCWebsite", dependencies: [
      "HaCWebsiteLib"
    ]),
    .testTarget(name: "HaCWebsiteLibTests", dependencies: [
      "HaCWebsiteLib"
    ])
  ],
  // Tell SwiftPM which versions of Swift we can run on
  swiftLanguageVersions: [4]
)