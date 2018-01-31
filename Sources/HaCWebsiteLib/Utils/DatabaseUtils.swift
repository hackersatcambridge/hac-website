import Foundation
import DotEnv
import Fluent
import PostgreSQLDriver

struct DatabaseURLComponents {
  let host: String
  let user: String
  let password: String
  let database: String
}

extension URL {
  var databaseURLComponents: DatabaseURLComponents? {
    if let host = self.host,
      let user = self.user,
      let password = self.password {
        let path = self.path
        return DatabaseURLComponents(
          host: host,
          user: user,
          password: password,
          database: String(path.dropFirst())
        )
    } else {
      return nil
    }
  }
}

enum DatabaseUtils {
  public static func prepareDatabase(withPreparations: [Preparation.Type]) {
    do {
      let driver = try getDatabaseDriver()
      let database = Database(driver)
      Database.default = database
      try database.prepare(withPreparations)
    } catch {
      print("Failed to prepare database")
    }
  }
}

private func getDatabaseDriver() throws -> PostgreSQLDriver.Driver {
    guard let databaseURLString = DotEnv.get("DATABASE_URL"),
      let databaseURL = URL(string: databaseURLString),
      let databaseURLComponents = databaseURL.databaseURLComponents 
    else {
      fatalError("Couldn't find valid DATABASE_URL environment variable")
    }
    let driver = try Driver(
      masterHostname: databaseURLComponents.host,
      readReplicaHostnames: [],
      user: databaseURLComponents.user,
      password: databaseURLComponents.password,
      database: databaseURLComponents.database
    )
    return driver
  }
