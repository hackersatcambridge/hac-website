import Credentials
import CredentialsHTTP
import DotEnv

struct CredentialsServer {
  static var credentials : Credentials {
    let credentials = Credentials()
    let basicCredentials = CredentialsHTTPBasic(verifyPassword: { userId, password, callback in
      if let storedPassword = DotEnv.get("API_PASSWORD"), storedPassword == password {
        callback(UserProfile(id: userId, displayName: userId, provider: "HTTPBasic"))
      } else {
        callback(nil)
      }
    })
    credentials.register(plugin: basicCredentials)
    return credentials
  }
}