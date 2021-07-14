import SwiftUI

struct LoadingImage: View {
  let imageSize: CGFloat?
  let cornerRadius: CGFloat
  @ObservedObject var viewModel: LoadingImageViewModel

  var body: some View {
    if let data = viewModel.imageData, let image = UIImage(data: data) {
      Image(uiImage: image)
        .resizable()
        .background(Color(.tertiarySystemFill))
        .frame(width: imageSize, height: imageSize)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    } else {
      Rectangle()
        .foregroundColor(Color(.tertiarySystemFill))
        .frame(width: imageSize, height: imageSize)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
  }
}
