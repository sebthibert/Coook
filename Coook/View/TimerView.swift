import SwiftUI

struct TimerView: View {
  let instructions: String?
  let totalTime: Int
  @State var timeRemaining: Int
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

  var body: some View {
    HStack {
      RoundedText(text: instructions ?? "No instructions", style: .callout, weight: .regular)
      Spacer()
      ProgressBar(totalTime: totalTime, timeRemaining: timeRemaining)
        .frame(width: 75, height: 75)
    }
    .onReceive(timer) { time in
      if self.timeRemaining > 0 {
        self.timeRemaining -= 1
      }
    }
  }
}
