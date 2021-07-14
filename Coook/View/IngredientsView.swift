import SwiftUI

struct IngredientsView: View {
  let isEditable: Bool
  let ingredientLists: [Recipe.IngredientList]

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      if isEditable == false {
        RoundedText(text: "Ingredients", style: .callout, weight: .bold)
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
  }
}

struct IngredientView: View {
  let isEditable: Bool
  let ingredient: Recipe.IngredientList.Ingredient
  @State var ingredientSelected = false

  var body: some View {
    HStack {
      if let description = ingredient.description {
        RoundedText(text: description, style: .footnote, weight: .regular)
          .foregroundColor(ingredientSelected ? Color.secondary : Color.primary)
      }
      if isEditable {
        Spacer()
        Button {
          ingredientSelected.toggle()
        } label: {
          Image(systemName: ingredientSelected ? "checkmark.circle.fill" : "circle")
        }
      }
    }
  }
}
