import SwiftUI
import SwiftUIKitView
import RubyAttribute

struct ContentView: View {
    var body: some View {
        UILabel()
            .swiftUIView(layout: .intrinsic)
            .set(\.attributedText,
                  to: try! NSAttributedString(AttributedString(localized:
"""
The ^[猫](CTRubyAnnotation: {before: 'ねこ', interCharacter: 'ㄇㄠ'}) \
is seeking adoption.
""", including: \.coreText), including: \.coreText))
            .set(\.textAlignment, to: .center)
            .set(\.font, to: .preferredFont(forTextStyle: .title1))
            .set(\.isUserInteractionEnabled, to: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
