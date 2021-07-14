import SwiftUI

struct ShareSheetModifer: ViewModifier {
  @Binding var showShareSheet: Bool
  @State var shareSheetItems: [Any] = []

  func body(content: Content) -> some View {
    content
      .sheet(isPresented: $showShareSheet) {
        ActivityViewController(activityItems: $shareSheetItems)
      }
  }
}
