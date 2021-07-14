import SwiftUI

struct CollectionView: View {
  var viewModel: RecipesViewModel

  @State private var searchText: String = ""

  var body: some View {
    ScrollView {
      LazyVGrid(columns: [GridItem(alignment: .top), GridItem(alignment: .top)]) {
        ForEach(allRecipes) { recipe in
          let viewModel = RecipeViewModel(recipe: recipe)
          RecipeGridItem(viewModel: viewModel)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
      }
      .padding()
    }
    .background(Color(.systemGroupedBackground))
    .navigationBarTitle(Text(viewModel.title))
    .searchable(text: $searchText)
  }

  var allRecipes: [Recipe] {
    guard searchText.count > 2 else {
      return viewModel.recipes
    }

    return viewModel.recipes.filter { $0.containsKeyword(searchText) }
  }
}
