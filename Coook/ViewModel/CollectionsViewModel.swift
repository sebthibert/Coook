import Combine
import SwiftUI

class CollectionsViewModel: ObservableObject {
  @Published var featuredCollection: Collection? = nil
  @Published var allCollections: [Collection] = []

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
        
        //insert egg recipe into main course collection
        
        let adjusted: [Collection] = collections.map { collection in
          if collection.title == "Main Courses" {
          return collection.adding(recipeId: 1234)
        }
          return collection
        }
        
        self.featuredCollection = adjusted.first
        self.allCollections = Array(adjusted.dropFirst())
      }
      )
  }
}
