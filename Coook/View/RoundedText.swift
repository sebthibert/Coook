import SwiftUI

struct RoundedText: View {
  let text: String
  let style: Font.TextStyle
  let weight: Font.Weight

  var body: some View {
    Text(text)
      .font(.system(style, design: .rounded))
      .fontWeight(weight)
  }
}
