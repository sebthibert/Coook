import SwiftUI

struct CollectionView: View {
  let viewModel: CollectionViewModel

  var body: some View {
    RecipeGrid(recipes: viewModel.recipes, title: viewModel.title)
  }
}
