import Combine
import SwiftUI

class TimersViewModel: ObservableObject {
  struct Timer: Identifiable {
    let id = UUID()
    let instructions: String?
    let totalSeconds: Int
    let dateInitiated: Date

    private var secondsSinceInitiated: Int {
      Calendar.current.dateComponents([.second], from: dateInitiated, to: Date()).second ?? 0
    }

    var secondsLeft: Int {
      totalSeconds - secondsSinceInitiated
    }
  }

  @Published var timers: [Timer] = []
}
