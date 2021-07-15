import SwiftUI

struct ProgressBar: View {
  let totalTime: Int
  let timeRemaining: Int
  private let showHours: Bool
  private let showMins: Bool

  init(totalTime: Int, timeRemaining: Int) {
    self.totalTime = totalTime
    self.timeRemaining = timeRemaining
    showHours = (totalTime / 3600) != 0
    showMins = ((totalTime % 3600) / 60) != 0
  }

  var progress: Float {
    Float(Double(timeRemaining) / Double(totalTime))
  }

  var hoursMinutesSeconds: String {
    let hoursInt = timeRemaining / 3600
    let minutesInt = (timeRemaining % 3600) / 60
    let secondsInt = (timeRemaining % 3600) % 60
    var string = ""
    if showHours {
      string = String(hoursInt) + ":"
    }
    if showMins {
      string += String(format: "%02d", minutesInt) + ":"
    }
    string += String(format: "%02d", secondsInt)
    return string
  }

  var body: some View {
    ZStack {
      Circle()
        .stroke(lineWidth: 5)
        .opacity(0.3)
        .foregroundColor(.green)

      Circle()
        .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
        .foregroundColor(.green)
        .rotationEffect(Angle(degrees: 270.0))
        .animation(.linear)

      RoundedText(text: timeRemaining == 0 ? "Done" : "\(hoursMinutesSeconds)", style: .callout, weight: .bold)
    }
  }
}
