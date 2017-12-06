import HaCTML
import DotEnv

struct GAScript: Nodeable {
  let googleAnalyticsId = DotEnv.get("GOOGLE_ANALYTICS_ID")
  var node: Node {
    guard let googleAnalyticsId = googleAnalyticsId else {
      return TextNode("")
    }
    return TextNode(
      """
      <!-- Global site tag (gtag.js) - Google Analytics -->
      <script async src=\"https://www.googletagmanager.com/gtag/js?id=\(googleAnalyticsId)\"></script>
      <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', '\(googleAnalyticsId)');
      </script>
      """
    , escapeLevel: .unsafeRaw)
  }
}
