import Foundation

extension UserDefaults {
  static func setFavourite(recipe: Recipe) {
    if let encodedRecipe = try? JSONEncoder().encode(recipe) {
      standard.set(encodedRecipe, forKey: String(recipe.id))
    }
  }

  static func removeFavourite(recipe: Recipe) {
    standard.removeObject(forKey: String(recipe.id))
  }

  static func isRecipeFavourited(_ recipe: Recipe) -> Bool {
    data(for: recipe) != nil
  }

  private static func data(for recipe: Recipe) -> Data? {
    standard.object(forKey: String(recipe.id)) as? Data
  }

  static func getFavourite(recipe: Recipe) -> Recipe? {
    guard let encodedRecipe = data(for: recipe) else {
      return nil
    }
    guard let recipe = try? JSONDecoder().decode(Recipe.self, from: encodedRecipe) else {
      return nil
    }
    return recipe
  }
}
