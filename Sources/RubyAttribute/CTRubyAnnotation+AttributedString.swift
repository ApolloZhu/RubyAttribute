import CoreText
import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

public enum RubyAnnotationAttribute: AttributedStringKey {
    public typealias Value = CTRubyAnnotation
    public static let name = kCTRubyAnnotationAttributeName as String
}

extension RubyAnnotationAttribute: CodableAttributedStringKey, MarkdownDecodableAttributedStringKey {
    enum CodingKeys: CodingKey, CaseIterable {
        case before
        case after
        case interCharacter
        case inline
    }
    
    public static func decode(from decoder: Decoder) throws -> CTRubyAnnotation {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            var text: [CTRubyPosition : String] = [:]
            for (position, codingKey) in zip(CTRubyPosition.allCases, CodingKeys.allCases) {
                text[position] = try? container.decode(String.self, forKey: codingKey)
            }
            if text.isEmpty {
                // force error
                _ = try container.decode(String.self, forKey: .before)
            }
            return CTRubyAnnotation.makeRubyAnnotation(text: text)
        } catch {
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)
            return CTRubyAnnotation.makeRubyAnnotation(text: [.before: string])
        }
    }
    
    public static func encode(_ value: CTRubyAnnotation, to encoder: Encoder) throws {
        var text: [CTRubyPosition : String] = [:]
        for position in CTRubyPosition.allCases {
            text[position] = value.text(for: position)
        }
        if text.count == 1 && text.keys.first == .before {
            var container = encoder.singleValueContainer()
            try container.encode(text.values.first!)
        } else {
            var container = encoder.container(keyedBy: CodingKeys.self)
            for (position, codingKey) in zip(CTRubyPosition.allCases, CodingKeys.allCases) {
                if let annotation = text[position] {
                    try container.encode(annotation, forKey: codingKey)
                }
            }
        }
    }
}

public extension AttributeScopes {
    struct CoreTextAttributes: AttributeScope {
        let rubyAnnotation: RubyAnnotationAttribute
        let foundation: FoundationAttributes
        #if canImport(SwiftUI)
        let swiftUI: SwiftUIAttributes
        #endif
    }
    
    var coreText: CoreTextAttributes.Type { CoreTextAttributes.self }
}

public extension AttributeDynamicLookup {
    subscript<T: AttributedStringKey>(dynamicMember keyPath: KeyPath<AttributeScopes.CoreTextAttributes, T>) -> T {
        return self[T.self]
    }
}
