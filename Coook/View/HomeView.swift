import SwiftUI

struct HomeView: View {
  @ObservedObject var viewModel: CollectionsViewModel
  @State private var searchText = ""
  
  var body: some View {
    List {
      Section(header: Text("Featured Collection")) {
        let viewModel = CollectionViewModel(collection: viewModel.featuredCollection)
        NavigationLink(destination: CollectionView(viewModel: viewModel)) {
          CollectionRow(imageSize: 100, viewModel: viewModel)
        }
      }
      Section(header: Text("All Collections")) {
        ForEach(allCollections) { collection in
          let viewModel = CollectionViewModel(collection: collection)
          NavigationLink(destination: CollectionView(viewModel: viewModel)) {
            CollectionRow(imageSize: 70, viewModel: viewModel)
          }
        }
      }
    }
    .onAppear {
      viewModel.getCollections()
    }
    .searchable(text: $searchText)
  }

  var allCollections: [Collection] {
    guard searchText.count > 2 else {
      return viewModel.allCollections
    }

    return viewModel.allCollections.filter { $0.title?.contains(searchText) ?? false }
  }
}
