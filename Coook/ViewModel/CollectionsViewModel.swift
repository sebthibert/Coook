import Combine
import SwiftUI

class CollectionsViewModel: ObservableObject {
  @Published var collections: [Collection] = []
  private var cancellable: Cancellable?

  func getCollections() {
    guard let url = URL(string: "https://api.cookwithmands.com/api/v1/collections") else { return }
    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .tryMap { data, response in
        try JSONDecoder().decode([Collection].self, from: data)
      }
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { _ in },
        receiveValue: { collections in
        self.collections = collections
      }
      )
  }
}
