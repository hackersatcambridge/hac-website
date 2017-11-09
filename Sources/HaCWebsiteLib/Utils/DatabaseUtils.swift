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
          database: String(path.characters.dropFirst())
        )
    } else {
      return nil
    }
  }
}

func getDatabaseDriver() throws -> PostgreSQLDriver.Driver {
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

func prepareDatabase() {
  do {
    let driver = try getDatabaseDriver()
    let database = Database(driver)
    Database.default = database
		try GeneralEvent.prepare(database)
  } catch {
    print("Failed to prepare database")
  }
}

/* 
EXAMPLE OF READING EVENT
let query = try GeneralEvent.makeQuery()
let event : GeneralEvent? = try query.filter("title", .equals, "Conquering Linux").first()
*/