import PackageDescription

let package = Package(
  name: "HaCWebsite",
  targets: [
    Target(name: "HaCWebsiteLib", dependencies: ["HaCTML"]),
    Target(name: "HaCWebsite", dependencies: ["HaCWebsiteLib"]),
    Target(name: "HaCTML")
  ],
  dependencies: [
    .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 6),
    .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 6),
    .Package(url: "https://github.com/IBM-Swift/Kitura-Markdown.git", majorVersion: 0),
    .Package(url: "https://github.com/hackersatcambridge/YamlSwift.git", majorVersion: 4, minor: 0),
    .Package(url: "https://github.com/jaredkhan/SwiftDotEnv.git", majorVersion: 1, minor: 2),
    .Package(url: "https://github.com/alexaubry/HTMLString", majorVersion: 3, minor: 0),
    .Package(url: "https://github.com/vapor/fluent.git", majorVersion: 2, minor: 3),
    .Package(url: "https://github.com/vapor-community/postgresql-driver.git", majorVersion: 2, minor: 0)
  ]
)
