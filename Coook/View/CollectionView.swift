import SwiftUI
import Algorithms

class RecipeSection: Identifiable {
  let mins: Int
  let recipes: [Recipe]

  init(mins: Int, recipes: [Recipe]) {
    self.mins = mins
    self.recipes = recipes
  }
}

struct CollectionView: View {
  var viewModel: RecipesViewModel

  @State private var searchText: String = ""

  var body: some View {
    ScrollView {
      ForEach(sectionedRecipes) { section in
        LazyVGrid(columns: [GridItem(alignment: .top), GridItem(alignment: .top)]) {
          ForEach(section.recipes) { recipe in
            let viewModel = RecipeViewModel(recipe: recipe)
            RecipeGridItem(viewModel: viewModel)
              .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
          }
        }
      }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
    .navigationBarTitle(Text(viewModel.title))
    .searchable(text: $searchText)
  }

  var sectionedRecipes: [RecipeSection] {
    let sorted = allRecipes.sorted { left, right in
      left.totalCookingTime < right.totalCookingTime
    }

    let sections = sorted.chunked(on: { $0.totalCookingTime }).map { RecipeSection(mins: $0.0, recipes: Array($0.1)) }

    return sections
  }

  var allRecipes: [Recipe] {
    guard searchText.count > 2 else {
      return viewModel.recipes
    }

    return viewModel.recipes.filter { $0.containsKeyword(searchText) }
  }
}
