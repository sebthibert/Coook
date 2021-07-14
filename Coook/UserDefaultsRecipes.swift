import Foundation

extension UserDefaults {
  static let recipeKeyPrefix = "MSCookRecipe:"

  static func setFavourite(recipe: Recipe) {
    if let encodedRecipe = try? JSONEncoder().encode(recipe) {
      standard.set(encodedRecipe, forKey: "\(recipeKeyPrefix) \(recipe.id)")
    }
  }

  static func removeFavourite(recipe: Recipe) {
    standard.removeObject(forKey: "\(recipeKeyPrefix) \(recipe.id)")
  }

  static func isRecipeFavourited(_ recipe: Recipe) -> Bool {
    data(forRecipe: recipe) != nil
  }

  private static func data(forRecipe recipe: Recipe) -> Data? {
    standard.object(forKey: "\(recipeKeyPrefix) \(recipe.id)") as? Data
  }

  static func getAllRecipes() -> [Recipe] {
    let keys = standard.dictionaryRepresentation().keys.filter { $0.contains(recipeKeyPrefix) }
    return keys.map { getFavourite(recipeKey: $0) }
  }

  private static func getFavourite(recipeKey: String) -> Recipe {
    let encodedRecipe = standard.object(forKey: recipeKey) as! Data
    let recipe = try! JSONDecoder().decode(Recipe.self, from: encodedRecipe)
    return recipe
  }
}
