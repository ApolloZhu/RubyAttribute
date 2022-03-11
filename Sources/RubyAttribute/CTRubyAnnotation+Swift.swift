import CoreText
import Foundation

public extension CTRubyAnnotation {
    static func makeRubyAnnotation(
        alignment: CTRubyAlignment = .auto,
        overhang: CTRubyOverhang = .auto,
        sizeFactor: CGFloat = 0.5,
        text: [CTRubyPosition: String]
    ) -> CTRubyAnnotation {
        var allAnnotations = (0..<CTRubyPosition.count.rawValue)
            .map {
                text[CTRubyPosition(rawValue: $0)!].map {
                    Unmanaged<CFString>.passRetained($0 as CFString)
                }
            }
        defer { allAnnotations.forEach { $0?.release() } }
        return CTRubyAnnotationCreate(alignment, overhang, sizeFactor, &allAnnotations)
    }
    
    var alignment: CTRubyAlignment {
        CTRubyAnnotationGetAlignment(self)
    }
    
    var overhang: CTRubyOverhang {
        CTRubyAnnotationGetOverhang(self)
    }
    
    var sizeFactor: CGFloat {
        CTRubyAnnotationGetSizeFactor(self)
    }
    
    func text(for position: CTRubyPosition) -> String? {
        CTRubyAnnotationGetTextForPosition(self, position) as? String
    }
}

extension CTRubyPosition: CaseIterable {
    public static var allCases: [CTRubyPosition] = [.before, .after, .interCharacter, .inline]
}
