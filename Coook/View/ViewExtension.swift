import SwiftUI

extension View {
  func shareSheet(showShareSheet: Binding<Bool>, items: [Any]) -> some View {
    self.modifier(ShareSheetModifer(showShareSheet: showShareSheet, shareSheetItems: items))
  }
}
