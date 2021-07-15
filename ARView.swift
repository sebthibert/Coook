import SwiftUI
import QuickLook
import ARKit

struct ARView: View {
  @Environment(\.presentationMode) var presentationMode
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      ARQuickLookView()
      Button("Close") {
        presentationMode.wrappedValue.dismiss()
      }
      .padding()
    }
  }
}

struct ARQuickLookView: UIViewControllerRepresentable {
   
    func makeCoordinator() -> ARQuickLookView.Coordinator {
        Coordinator()
    }
    
    func makeUIViewController(context: Context) -> QLPreviewController {
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ controller: QLPreviewController,
context: Context) {
    }
    
    class Coordinator: NSObject, QLPreviewControllerDataSource {
        private lazy var fileURL: URL = Bundle.main.url(forResource: "egg2", withExtension: "usdz")!
      
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }
        
        func previewController(_ controller: QLPreviewController,previewItemAt index: Int) -> QLPreviewItem {
            let item = ARQuickLookPreviewItem(fileAt: fileURL)
            item.allowsContentScaling = false
            return item
        }
    }
}

