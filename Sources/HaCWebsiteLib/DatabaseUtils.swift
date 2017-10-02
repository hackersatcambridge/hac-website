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

func testDatabase() {
  do {
    guard let databaseURLString = DotEnv.get("DATABASE_URL"),
      let databaseURL = URL(string: databaseURLString),
      let databaseURLComponents = databaseURL.databaseURLComponents else {
      fatalError("Couldn't find valid DATABASE_URL environment variable")
    }

    let driver = try Driver(
      masterHostname: databaseURLComponents.host,
      readReplicaHostnames: [],
      user: databaseURLComponents.user,
      password: databaseURLComponents.password,
      database: databaseURLComponents.database
    )
    let database = Database(driver)
    Database.default = database
    try Pet.prepare(database)
  } catch {
    print("Failed to initialise database:")
    dump(error)
  }

  do {
    let testPet = Pet(name: "Fluffs", age: 1)
    try testPet.save()
  } catch {
    print("Failed to add record")
    dump(error)
  }
}