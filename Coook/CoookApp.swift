import SwiftUI

var globalRecipes: [Recipe] = []

@main
struct CoookApp: App {
  let viewModel = CollectionsViewModel()
  
  var body: some Scene {
    WindowGroup {
      TabView {
        NavigationView {
          HomeView(viewModel: viewModel)
            .navigationBarTitle(Text("Cook with M&S"))
        }
        .tabItem {
          Label("Home", systemImage: "house")
        }
        NavigationView {
          CollectionView(viewModel: FavouriteRecipesViewModel())
        }
        .tabItem {
          Label("Favourites", systemImage: "heart")
        }
        NavigationView {
          ShoppingListsView(viewModel: ShoppingListsViewModel())
        }
        .tabItem {
          Label("Shopping Lists", systemImage: "list.bullet")
        }
      }

      .onAppear {
        decodeRecipes()
      }
    }
  }

  private func decodeRecipes() {
    guard let path = Bundle.main.path(forResource: "recipes", ofType: "json") else { return }
    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      let allRecipes = try JSONDecoder().decode([Recipe].self, from: data)
      globalRecipes = allRecipes.filter { $0.hidden == false }
    } catch {
      print(error)
    }
  }
}
