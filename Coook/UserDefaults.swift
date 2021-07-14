import Foundation

extension UserDefaults {
  static let keyPrefix = "MSCookRecipe:"

  static func setFavourite(recipe: Recipe) {
    if let encodedRecipe = try? JSONEncoder().encode(recipe) {
      standard.set(encodedRecipe, forKey: "\(keyPrefix) \(recipe.id)")
    }
  }

  static func removeFavourite(recipe: Recipe) {
    standard.removeObject(forKey: "\(keyPrefix) \(recipe.id)")
  }

  static func isRecipeFavourited(_ recipe: Recipe) -> Bool {
    data(for: recipe) != nil
  }

  private static func data(for recipe: Recipe) -> Data? {
    standard.object(forKey: "\(keyPrefix) \(recipe.id)") as? Data
  }

  static func getAllRecipeKeys() -> [String] {
    standard.dictionaryRepresentation().keys.filter { $0.contains(keyPrefix) }
  }

  static func getFavourite(recipeKey: String) -> Recipe {
    let encodedRecipe = standard.object(forKey: recipeKey) as! Data
    let recipe = try! JSONDecoder().decode(Recipe.self, from: encodedRecipe)
    return recipe
  }
}
