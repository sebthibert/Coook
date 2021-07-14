import Foundation
struct FavouriteRecipesViewModel: RecipesViewModel {
  let recipes = UserDefaults.getAllRecipes()
  let title = "Favourites"
}
