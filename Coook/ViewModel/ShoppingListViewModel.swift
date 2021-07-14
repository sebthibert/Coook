import SwiftUI

class ShoppingListViewModel: ObservableObject {
  let recipe: Recipe
  let getShoppingLists: () -> Void
  @ObservedObject var loadingImageViewModel = LoadingImageViewModel()

  init(recipe: Recipe, getShoppingLists: @escaping () -> Void) {
    self.recipe = recipe
    self.getShoppingLists = getShoppingLists
    loadingImageViewModel.getImage(path: recipe.photo?.urls?.small)
  }
}
