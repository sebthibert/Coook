import SwiftUI

struct RecipeGridItem: View {
  @ObservedObject var viewModel: RecipeViewModel

  var body: some View {
    VStack(spacing: 0) {
      NavigationLink(destination: RecipeView(viewModel: viewModel)) {
        LoadingImage(imageSize: nil, cornerRadius: 0, viewModel: viewModel.loadingImageViewModel)
          .scaledToFit()
      }
      VStack(spacing: 8) {
        HStack {
          if let title = viewModel.recipe.title {
            RoundedText(text: title, style: .footnote, weight: .heavy)
              .foregroundColor(Color(.label))
          }
          Spacer()
        }
        HStack {
          if let time = viewModel.recipe.totalCookingTime {
            RoundedText(text: "\(time)m", style: .caption, weight: .bold)
              .foregroundColor(.secondary)
          }
          Spacer()
        }
      }
      .padding(8)
      .background(Color(.systemBackground))
    }
  }
}
