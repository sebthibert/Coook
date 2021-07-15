import SwiftUI

extension View {
  func shareSheet(showShareSheet: Binding<Bool>, items: [Any]) -> some View {
    self.modifier(ShareSheetModifer(showShareSheet: showShareSheet, shareSheetItems: items))
  }
  
  @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
    if condition {
      transform(self)
    } else {
      self
    }
  }
}
