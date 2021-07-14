import SwiftUI

class ShoppingListViewModel: ObservableObject {
  let recipe: Recipe
  @ObservedObject var loadingImageViewModel = LoadingImageViewModel()

  init(recipe: Recipe) {
    self.recipe = recipe
    loadingImageViewModel.getImage(path: recipe.photo?.urls?.small)
  }
}
