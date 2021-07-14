import SwiftUI

class RecipeViewModel: ObservableObject {
  let recipe: Recipe
  @ObservedObject var loadingImageViewModel = LoadingImageViewModel()
  @ObservedObject var timersViewModel = TimersViewModel()

  init(recipe: Recipe) {
    self.recipe = recipe
    self.loadingImageViewModel.getImage(path: recipe.photo?.urls?.small)
  }
}
