import Combine
import SwiftUI

class ShoppingListsViewModel: ObservableObject {
  @Published var shoppingLists: [Recipe] = []

  func getShoppingLists() {
    shoppingLists = UserDefaults.getAllShoppingListRecipes()
  }
}
