import HaCTML
import Foundation
import DotEnv

struct GAScript: Nodeable {
  var node: Node {
    return TextNode(
      """
      <!-- Global site tag (gtag.js) - Google Analytics -->
      <script async src=\"https://www.googletagmanager.com/gtag/js?id=\(DotEnv.get("GOOGLE_ANALYTICS_ID")!)\"></script>
      <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', '\(DotEnv.get("GOOGLE_ANALYTICS_ID")!)');
      </script>
      """
    , escapeLevel: .unsafeRaw)
  }
}
