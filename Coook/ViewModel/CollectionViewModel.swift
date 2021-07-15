import SwiftUI

class CollectionViewModel: ObservableObject {
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

