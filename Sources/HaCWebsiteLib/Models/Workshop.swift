import Foundation

/// Represents a workshop
// TODO: Rename this struct to `Workshop` when it's ready for use
public struct Workshop {
  let title: String

  /// People that have directly contributed content to this workshop
  let contributors: [String]

  /// Non-contributors we would like to thank for helping to inspire, develop or facilitate this workshop
  let thanks: [String]

  /// Links that attendees may wish to read after the workhsop
  let furtherReadingLinks: [Link]

  /// A link to a video recording of this workshop
  let recordingLink: URL?

  /// A link to any slides for this workshop
  let slidesLink: URL?

  /// A set of keywords associated with the workshop
  let tags: [String]

  /// A string of a https://spdx.org/licenses/ license identifier
  // TODO: Make a type safe version of this
  let license: String

  /// The prose content that accompanies the workshop (and slides)
  let notes: Markdown

  /// The prose advice for presenters of this workshop
  let presenterGuide: Markdown?

  /// A URL to a promotional image for the workshop, to be displayed on top of `promoImageBackground`
  let promoImageForeground: String

  /// The background for `promoImageForeground`
  let promoImageBackground: Background

  /// Prose describing the nature of the workshop
  let description: Markdown

  /// Prose describing what attendees should already know
  let prerequisites: Markdown

  /// Prose describing how attendees should prepare for the workshop
  let setupInstructions: Markdown

  /// The ID of the workshop as determined by its workshop repository URL
  let workshopId: String

  /// A link to code examples for this workshop
  let examplesLink: URL?

  var hero: ImageHero {
    return ImageHero(
        background: self.promoImageBackground,
        imagePath: self.promoImageForeground,
        alternateText: self.title
      )
  }
}
