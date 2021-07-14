import SwiftUI

struct EmptyShoppingListView: View {
  let description: String
  let imageName: String
  let instruction: String

  var body: some View {
    HStack {
      Spacer(minLength: 32)
      VStack(spacing: 32) {
        Spacer(minLength: 150)
        RoundedText(text: description, style: .title2, weight: .bold)
        VStack {
          HStack {
            RoundedText(text: "Tap the", style: .body, weight: .regular)
            Image(systemName: imageName)
            RoundedText(text: "button ", style: .body, weight: .regular)
          }
          RoundedText(text: instruction, style: .body, weight: .regular)
        }
      }
      Spacer(minLength: 32)
    }
  }
}

