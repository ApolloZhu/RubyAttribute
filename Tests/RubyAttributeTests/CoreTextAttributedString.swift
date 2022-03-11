import Foundation

// https://developer.apple.com/forums/thread/689932
@dynamicMemberLookup
struct CoreTextAttributedString: Codable, CustomStringConvertible {
    @CodableConfiguration(from: \.coreText)
    var attributedString: AttributedString = AttributedString()
    
    var description: String {
        attributedString.description
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<AttributedString, T>) -> T {
        attributedString[keyPath: keyPath]
    }
}
