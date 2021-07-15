import SwiftUI

class RecipeSection: Identifiable {
  let mins: Int
  let recipes: [Recipe]

  init(mins: Int, recipes: [Recipe]) {
    self.mins = mins
    self.recipes = recipes
  }
}
