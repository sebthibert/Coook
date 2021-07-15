import SwiftUI

struct FavouritesView: View {
  @ObservedObject var viewModel: FavouriteRecipesViewModel

  var body: some View {
    RecipeGrid(recipes: viewModel.recipes, title: "Favourites")
      .onAppear {
        viewModel.getRecipes()
      }
  }
}
