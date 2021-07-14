import SwiftUI

struct ShoppingListsView: View {
  @ObservedObject var viewModel: ShoppingListsViewModel

  var body: some View {
    ScrollView {
      ForEach(viewModel.shoppingLists) { recipe in
        Section {
          ShoppingListRow(viewModel: ShoppingListViewModel(recipe: recipe))
            .padding(.horizontal)
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
