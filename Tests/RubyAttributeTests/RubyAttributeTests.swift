import XCTest
import Foundation
@testable import RubyAttribute

final class RubyAttributeTests: XCTestCase {
    func testExample() throws {
        let string = CoreTextAttributedString(attributedString: try AttributedString(
            markdown: "^[猫](CTRubyAnnotation: {before: 'ねこ', interCharacter: 'ㄇㄠ'})",
            including: \.coreText,
            options: .init(allowsExtendedAttributes: true)
        ))
        let encoded = String(data: try! JSONEncoder().encode(string), encoding: .utf8)!
        XCTAssert(encoded.contains(#"{"CTRubyAnnotation":{"before":"ねこ","interCharacter":"ㄇㄠ"}"#))
    }
}
