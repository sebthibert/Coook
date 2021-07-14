import SwiftUI

struct TimerView: View {
  let instructions: String?
  let totalTime: Int
  @State var timeRemaining: Int
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

  var body: some View {
    HStack(spacing: 16) {
      RoundedText(text: instructions ?? "No instructions", style: .callout, weight: .regular)
      ProgressBar(progress: Float(Double(timeRemaining) / Double(totalTime)), timeRemaining: timeRemaining)
        .frame(width: 75, height: 75)
    }
    .onReceive(timer) { time in
      if self.timeRemaining > 0 {
        self.timeRemaining -= 1
      }
    }
  }
}
