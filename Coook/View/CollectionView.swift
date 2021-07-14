import SwiftUI

struct CollectionView: View {
  var viewModel: RecipesViewModel

  var body: some View {
    ScrollView {
      LazyVGrid(columns: [GridItem(alignment: .top), GridItem(alignment: .top)]) {
        ForEach(viewModel.recipes) { recipe in
          let viewModel = RecipeViewModel(recipe: recipe)
          RecipeGridItem(viewModel: viewModel)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
      }
      .padding()
    }
    .background(Color(.systemGroupedBackground))
    .navigationBarTitle(Text(viewModel.title))
  }
}
