import SwiftUI

struct HomeView: View {
  @ObservedObject var viewModel: CollectionsViewModel

  var body: some View {
    List {
      Section(header: Text("Featured Collection")) {
        let collection = viewModel.collections.first
        let viewModel = CollectionViewModel(collection: collection)
        NavigationLink(destination: CollectionView(viewModel: viewModel)) {
          CollectionRow(imageSize: 100, viewModel: viewModel)
        }
      }
      Section(header: Text("All Collections")) {
        ForEach(viewModel.collections.dropFirst()) { collection in
          let viewModel = CollectionViewModel(collection: collection)
          NavigationLink(destination: CollectionView(viewModel: viewModel)) {
            CollectionRow(imageSize: 70, viewModel: viewModel)
          }
        }
      }
    }
    .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          NavigationLink(destination: Text("Hello")) {
            Image(systemName: "person.crop.circle.fill")
          }
        }
    }
    .onAppear {
      viewModel.getCollections()
    }
  }
}
