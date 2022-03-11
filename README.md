# RubyAttribute

CTRubyAnnotation + AttributedString

![What is the cat doing here? with ruby annotations on the word cat](https://user-images.githubusercontent.com/10842684/157847662-0e418f2a-3142-4bbd-9c9e-979bd586cc50.png)

## Why Display in UILabel + NSAttributedString

0. Foundation/SwiftUI/UIKit/CoreText forgot to add `kCTRubyAnnotationAttributeName` to `AttributedString` (FB9953514)
1. SwiftUI `Text` ignores custom attributes
2. `UITextView` doesn't work because reasons

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
