import SwiftUI

struct CollectionRow: View {
  let imageSize: CGFloat?
  @ObservedObject var viewModel: CollectionViewModel

  var body: some View {
    HStack(alignment: .top) {
      LoadingImage(imageSize: imageSize, cornerRadius: 10, viewModel: viewModel.loadingImageViewModel)
      VStack(alignment: .leading, spacing: 4) {
        VStack(alignment: .leading, spacing: 8) {
          if let title = viewModel.collection?.title {
            RoundedText(text: title, style: .callout, weight: .heavy)
          }
          if let description = viewModel.collection?.trimmedDescription {
            RoundedText(text: description, style: .footnote, weight: .regular)
          }
        }
        if let recipeCount = viewModel.collection?.recipes?.count {
          RoundedText(text: "\(recipeCount) recipes", style: .caption, weight: .bold)
            .foregroundColor(.secondary)
        }
      }
    }
  }
}
