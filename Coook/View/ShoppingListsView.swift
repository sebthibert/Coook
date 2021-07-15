import SwiftUI

struct ShoppingListsView: View {
  @ObservedObject var viewModel: ShoppingListsViewModel

  var body: some View {
    ScrollView {
      if viewModel.shoppingLists.isEmpty {
        EmptyRecipeGrid(description: "You don't have any ingredients in your shopping list yet!", imageName: "text.badge.plus", instruction: "to add ingredients for a recipe.")
      } else {
        ForEach(viewModel.shoppingLists) { recipe in
          Section {
            ShoppingListRow(viewModel: ShoppingListViewModel(recipe: recipe, getShoppingLists: viewModel.getShoppingLists))
              .padding(.horizontal)
          }
        }
      }
    }
    .onAppear {
      viewModel.getShoppingLists()
    }
    .background(Color(.systemGroupedBackground))
    .navigationBarTitle("Shopping Lists")
  }
}
