import Foundation
import SwiftyJSON

public struct BlogPostManager {
  public private(set) static var allPosts: [BlogPost] = []

  public static func posts(since date: Date) -> [BlogPost] {
    return allPosts.filter { (post: BlogPost) -> Bool in
      return post.datePublished >= date
    }
  }

  public static func update() {
    let result = try? String(
      contentsOf: URL(
        string: "https://medium.com/hackers-at-cambridge?format=json"
      )!,
      encoding: .utf8
    )

    guard let resultJSONString = result else {
      print("Failed to get blog posts from Medium.com")
      return
    }

    // Medium prepends all JSONs with a while(1) to stop malicious execution (https://stackoverflow.com/a/2669766)
    let cleanJSONString = resultJSONString.replacingOccurrences(of: "])}while(1);</x>", with: "")
    let json = JSON.parse(string: cleanJSONString)

    guard let streamItems = json["payload"]["streamItems"].array else {
      print("Not found!")
      return
    }

    let postIds = streamItems
      .flatMap({ $0["section"]["items"].arrayValue })
      .flatMap({ $0["post"]["postId"].string })

    let postJSONs = postIds
      .map({ (postId: String) -> JSON in
        var post = json["payload"]["references"]["Post"][postId]
        post["creator"] = json["payload"]["references"]["User"][post["creatorId"].stringValue]
        return post
      })

    allPosts = postJSONs.map { (post: JSON) -> BlogPost in
      let imageId = post["virtuals"]["previewImage"]["imageId"].stringValue

      return BlogPost(
        title: post["title"].stringValue,
        url: "https://medium.com/hackers-at-cambridge/\(post["uniqueSlug"].stringValue)",
        datePublished: Date(timeIntervalSince1970: post["firstPublishedAt"].doubleValue / 1000.0),
        previewImageURL: "https://cdn-images-1.medium.com/max/2000/gradv/29/81/30/darken/25/\(imageId)",
        author: post["creator"]["name"].stringValue
      )
    }
  }
}
