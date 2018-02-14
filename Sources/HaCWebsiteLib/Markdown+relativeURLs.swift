import Regex
import Foundation

extension Markdown {
  /*
   * Markdown references (links and images) can contain relative URLs
   * This method will resolve relative URLs relative to a given base
   * e.g. '[Meow](images/cat.png)' -> '[Meow](https://hackersatcambridge.com/images/cat.png)'
   * Note: Does not handle commented or nested references (see #208)
   */ 
  func resolvingRelativeURLs(relativeTo baseURL: URL) -> Markdown {

    // See https://regexr.com/3jh10 for demo of this regex
    let referenceTitleRegexString = 
      "\\[" + // Opening '['
      "([^\\[\\]]*?)" + // Capture 1: The optional reference title
      "]" // Closing ']'

    let referenceURLRegexString =
      "\\(" + // Opening '('
      "([^)]*?)" + // Capture 2: The URL
      "\\)" // Closing ')'

    let referenceRegexString =
      "(!?)" +  // Capture 0: The optional '!' to indicate image references
      referenceTitleRegexString +
      referenceURLRegexString

    let referenceRegex = try! Regex(string: referenceRegexString)
    let referenceMatches = referenceRegex.allMatches(in: raw).sorted {
      // Sort matches from back to front so that we don't mess up ranges as we make replacements
      $0.range.lowerBound > $1.range.lowerBound
    }
    
    var translatedRaw = raw
    for match in referenceMatches {
      let exclamationPoint = match.captures[0]!
      let title = match.captures[1]!
      let url = match.captures[2]!

      let translatedURL = URL(string: url, relativeTo: baseURL)?.absoluteString ?? ""
      let translatedReference = "\(exclamationPoint)[\(title)](\(translatedURL))"
      translatedRaw.replaceSubrange(match.range, with: translatedReference)
    }

    return Markdown(translatedRaw)
  }
}