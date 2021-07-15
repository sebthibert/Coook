import SwiftUI
import Algorithms

struct RecipeGrid: View {
  let recipes: [Recipe]
  let title: String
  @State private var searchText: String = ""

  var body: some View {
    ScrollView {
      LazyVGrid(columns: [GridItem(alignment: .top), GridItem(alignment: .top)]) {
        ForEach(allRecipes) { recipe in
          let viewModel = RecipeViewModel(recipe: recipe)
          RecipeGridItem(viewModel: viewModel)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
      }
      .padding()
    }
    .background(Color(.systemGroupedBackground))
    .navigationBarTitle(Text(title))
    .searchable(text: $searchText)
  }

  var sectionedRecipes: [RecipeSection] {
    let sorted = allRecipes.sorted { left, right in
      left.totalCookingTime > right.totalCookingTime
    }

    let sections = sorted.chunked(on: { $0.totalCookingTime }).map { RecipeSection(mins: $0.0, recipes: Array($0.1)) }

    return sections
  }

  var allRecipes: [Recipe] {
    guard searchText.count > 2 else {
      return recipes
    }

    return recipes.filter { $0.containsKeyword(searchText) }
  }
}
