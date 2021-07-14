import SwiftUI

protocol RecipesViewModel {
  var recipes: [Recipe] { get }
  var title: String { get }
}

class CollectionViewModel: ObservableObject, RecipesViewModel {
  let collection: Collection?
  @ObservedObject var loadingImageViewModel = LoadingImageViewModel()

  var recipes: [Recipe] {
    let recipeIDs = collection?.recipes ?? []
    return globalRecipes.filter { recipeIDs.contains($0.id) }
  }

  init(collection: Collection?) {
    self.collection = collection
    loadingImageViewModel.getImage(path: collection?.img?.urls?.tiny)
  }

  var title: String {
    collection?.title ?? "No title"
  }
}

