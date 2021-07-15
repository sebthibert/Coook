import SwiftUI

struct HomeView: View {
  @ObservedObject var viewModel: CollectionsViewModel

  @State private var searchText = ""
  @State private var isPresentingProfile = false
  
  var body: some View {
    List {
      Section(header: Text("Featured Collection")) {
        let viewModel = CollectionViewModel(collection: viewModel.featuredCollection)
        NavigationLink(destination: CollectionView(viewModel: viewModel)) {
          CollectionRow(imageSize: 100, viewModel: viewModel)
        }
      }
      sparksBanner
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
    .sheet(isPresented: $isPresentingProfile) {
      LinkSparksView(viewModel: LinkSparksViewModel())
    }
  }

  var sparksBanner: some View {
    Button {
      isPresentingProfile = true
    } label: {
      HStack {
        Spacer()
        VStack(alignment: .center, spacing: 16) {
          Image(uiImage: UIImage(named: "logo")!)
            .padding()
            .frame(height: 22)
          Text("Join for exclusive benefits & recipes")
            .foregroundColor(.white)
            .font(.subheadline)
            .multilineTextAlignment(.center)
        }
        Spacer()
      }      .padding()
        .background(Color(UIColor(red: 5/255, green: 50/255, blue: 45/255, alpha: 1)))
        .cornerRadius(10)
    }
  }

  var allCollections: [Collection] {
    guard searchText.count > 2 else {
      return viewModel.allCollections
    }

    return viewModel.allCollections.filter { $0.title?.contains(searchText) ?? false }
  }
}
