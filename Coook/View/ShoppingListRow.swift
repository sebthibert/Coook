import SwiftUI

struct ShoppingListRow: View {
  @ObservedObject var viewModel: ShoppingListViewModel

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      HStack(alignment: .top) {
        LoadingImage(imageSize: 70, cornerRadius: 10, viewModel: viewModel.loadingImageViewModel)
        VStack(alignment: .leading, spacing: 8) {
          if let title = viewModel.recipe.title {
            RoundedText(text: title, style: .callout, weight: .heavy)
          }
          if let servings = viewModel.recipe.servings {
            RoundedText(text: "Serves \(servings)", style: .caption, weight: .bold)
              .foregroundColor(.secondary)
          }
        }
        Spacer()
        Button {
          UserDefaults.removeShoppingList(forRecipe: viewModel.recipe)
          viewModel.getShoppingLists()
        } label: {
          Image(systemName: "trash")
        }
      }
      .padding()
      .background(Color.white)
      .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
      IngredientsView(isEditable: true, ingredientLists: viewModel.recipe.ingredientListsWithIngredients)
        .padding(.horizontal)
    }
  }
}
