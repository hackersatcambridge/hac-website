import KituraMarkdown

/**
 * A structure for text that requires rendering for display
 */
struct Text {
  let markdown: String

  var html: String {
    return KituraMarkdown.render(from: markdown)
  }
}