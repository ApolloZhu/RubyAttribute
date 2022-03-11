# RubyAttribute

CTRubyAnnotation + AttributedString

## Why Display in UILabel + NSAttributedString

0. Foundation/SwiftUI/UIKit/CoreText forgot to add `kCTRubyAnnotationAttributeName` to `AttributedString` (FB9953514)
1. SwiftUI `Text` ignores custom attributes
2. `UITextView` doesn't work for reasons

> Note: remember adding `including: \.coreText` when constructing `NSAttributedString` or else it will ignore custom attributes as well.

## Usage

Construct AttributedString directly:

```swift
var attributes = AttributeContainer()
attributes.rubyAnnotation = .makeRubyAnnotation(text: [.before: "ねこ"])
let attributedString = AttributedString("猫", attributes: attributes)
```

... or from markdown:

```swift
// defaults to before
try AttributedString(
    markdown: "^[猫](CTRubyAnnotation: 'ねこ')",
    including: \.coreText,
    options: .init(allowsExtendedAttributes: true)
)

// but you can specify where exactly, or even multiple positions
AttributedString(localized:
"""
The ^[猫](CTRubyAnnotation: {interCharacter: 'ㄇㄠ', after: 'cat'}) \
is seeking adoption.
""", including: \.coreText)
```
