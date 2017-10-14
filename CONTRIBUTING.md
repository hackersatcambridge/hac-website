# Where to start?

This document describes everything to do with contributing to this repository,
including commit style, coding style, submitting issues, and making pull
requests.

If you want to contribute and don't know where to start, we are a bunch of
incredibly friendly people who are very eager to help you out! A good place to
go is to look at our
[issues list](https://github.com/hackersatcambridge/hac-website/issues)
for anything tagged with the
[`good first issue`](https://github.com/hackersatcambridge/hac-website/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22)
label.

# Issues

In order to make our lives as easy as possible when submitting an issue, please
try and make everything as clear as possible. Label the issue appropriately
whether it's a
[`bug`](https://github.com/hackersatcambridge/hac-website/issues?q=is%3Aopen+is%3Aissue+label%3Abug)
or a possible
[`enhancement`](https://github.com/hackersatcambridge/hac-website/issues?q=is%3Aopen+is%3Aissue+label%3Aenhancement),
and ensure that if it is a bug, that as much information as possible is there to
help us reproduce it.

# Pull Requests

If the pull request should resolve any issues, please list them in a comment!

# Commits

The subject line should be in the imperative and be less than 50 characters
in length.

(If this helps, imagine saying the sentence "This commit will SUBJECT_LINE".
eg. "This commit will `Add the ability to create ice cream`")

Do not end the subject line with a period.

Leave a gap between the subject line and the body.

Wrap the body at 72 characters.

For more info on committing, please read
[this](https://chris.beams.io/posts/git-commit/).

# Coding Standards

### Tabs or Spaces?

Indentations are done with **2** spaces, for all languages and file formats:
```swift
public struct AttributeKey<Value> {
  let keyName: String
  let applyFunc: (Value) -> AttributeValue

  internal init(_ key: String, apply: @escaping (Value) -> AttributeValue) {
    self.keyName = key
    self.applyFunc = apply
  }
}
```

### Our Stylesheets and Their BEM

CSS is great but it's easy to end up with hundreds of classes that overlap, underlap and wrestle with each other and that's when things get a whole lot less fun. To keep our stylesheets from this fate, we adopt Airbnb's naming convention for CSS. You can read about that [here](https://github.com/airbnb/css#oocss-and-bem).