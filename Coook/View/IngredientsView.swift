import SwiftUI

struct IngredientsView: View {
  let recipe: Recipe?
  let isEditable: Bool
  let ingredientLists: [Recipe.IngredientList]
  @State var isShoppingListSaved: Bool = false

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      if isEditable == false {
        HStack {
          RoundedText(text: "Ingredients", style: .callout, weight: .bold)
          Spacer()
          if ingredientLists.count == 1 {
            Button(action: {
              toggleShoppingList()
            }, label: {
              Image(systemName: isShoppingListSaved ? "text.badge.minus" : "text.badge.plus")
            })
          }
        }
      }
      ForEach(ingredientLists) { ingredientList in
        VStack(alignment: .leading, spacing: 16) {
          if let title = ingredientList.title, !title.isEmpty {
            RoundedText(text: title, style: .footnote, weight: .regular)
          }
          ForEach(ingredientList.ingredients ?? []) { ingredient in
            IngredientView(isEditable: isEditable, ingredient: ingredient)
            Divider()
          }
        }
      }
    }
    .onAppear {
      guard let recipe = recipe else {
        return
      }
      isShoppingListSaved = UserDefaults.isShoppingListSaved(recipe)
    }
  }

  func toggleShoppingList() {
    guard let recipe = recipe else {
      return
    }
    if UserDefaults.isShoppingListSaved(recipe) {
      UserDefaults.removeShoppingList(forRecipe: recipe)
      isShoppingListSaved = false
    } else {
      UserDefaults.setShoppingList(forRecipe: recipe)
      isShoppingListSaved = true
    }
  }
}
