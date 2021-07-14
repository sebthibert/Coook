import Foundation

extension UserDefaults {
  static let shoppingListKeyPrefix = "MSCookShoppingList:"

  static func setShoppingList(forRecipe recipe: Recipe) {
    if let encodedRecipe = try? JSONEncoder().encode(recipe) {
      standard.set(encodedRecipe, forKey: "\(shoppingListKeyPrefix) \(recipe.id)")
    }
  }

  static func removeShoppingList(forRecipe recipe: Recipe) {
    standard.removeObject(forKey: "\(shoppingListKeyPrefix) \(recipe.id)")
  }

  static func isShoppingListSaved(_ recipe: Recipe) -> Bool {
    data(forShoppingList: recipe) != nil
  }

  private static func data(forShoppingList recipe: Recipe) -> Data? {
    standard.object(forKey: "\(shoppingListKeyPrefix) \(recipe.id)") as? Data
  }

  static func getAllShoppingListRecipes() -> [Recipe] {
    let keys = standard.dictionaryRepresentation().keys.filter { $0.contains(shoppingListKeyPrefix) }
    return keys.map { getShoppingListRecipe(withKey: $0) }
  }

  private static func getShoppingListRecipe(withKey key: String) -> Recipe {
    let encodedShoppingList = standard.object(forKey: key) as! Data
    let shoppingList = try! JSONDecoder().decode(Recipe.self, from: encodedShoppingList)
    return shoppingList
  }
}

