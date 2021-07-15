import Foundation

class FavouriteRecipesViewModel: ObservableObject {
  @Published var recipes: [Recipe] = []

  func getRecipes() {
    recipes = UserDefaults.getAllRecipes()
  }
}
