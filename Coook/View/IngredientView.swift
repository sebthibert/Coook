import SwiftUI

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
