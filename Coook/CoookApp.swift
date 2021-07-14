import SwiftUI

var globalRecipes: [Recipe] = []

@main
struct CoookApp: App {
  let viewModel = CollectionsViewModel()
  
  var body: some Scene {
    WindowGroup {
      NavigationView {
        HomeView(viewModel: viewModel)
          .navigationBarTitle(Text("Cook with M&S"))
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
