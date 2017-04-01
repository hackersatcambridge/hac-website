import KituraMarkdown

/**
 * A structure for text that requires rendering for display
 */
struct Text {
  let markdown: String
  let html: String

  init(markdown: String) {
    self.markdown = markdown
    self.html = KituraMarkdown.render(from: markdown)
  }
}