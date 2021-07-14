import Combine
import SwiftUI

class LoadingImageViewModel: ObservableObject {
  @Published var imageData: Data?
  private var cancellable: Cancellable?

  func getImage(path: String?) {
    guard let path = path, let url = URL(string: path) else { return }
    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .map { $0.data }
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { _ in },
        receiveValue: { data in
        self.imageData = data
      }
      )
  }
}
