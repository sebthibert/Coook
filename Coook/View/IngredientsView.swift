import SwiftUI

struct IngredientsView: View {
  let ingredientLists: [Recipe.IngredientList]

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      RoundedText(text: "Ingredients", style: .callout, weight: .bold)
      ForEach(ingredientLists) { ingredientList in
        VStack(alignment: .leading, spacing: 16) {
          if let title = ingredientList.title, !title.isEmpty {
            RoundedText(text: title, style: .footnote, weight: .regular)
          }
          ForEach(ingredientList.ingredients ?? []) { ingredient in
            if let description = ingredient.description {
              RoundedText(text: description, style: .footnote, weight: .regular)
            }
            Divider()
          }
        }
      }
    }
  }
}
