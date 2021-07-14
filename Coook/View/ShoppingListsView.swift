import SwiftUI

struct ShoppingListsView: View {
  @ObservedObject var viewModel: ShoppingListsViewModel

  var body: some View {
    List {
      ForEach(viewModel.shoppingLists) { recipe in
        Section {
          ShoppingListRow(viewModel: ShoppingListViewModel(recipe: recipe))
        }
      }
    }
    .onAppear {
      viewModel.getShoppingLists()
    }
    .navigationBarTitle("Shopping Lists")
  }
}
