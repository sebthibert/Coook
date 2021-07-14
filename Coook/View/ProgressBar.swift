import SwiftUI

struct ProgressBar: View {
  let progress: Float
  let timeRemaining: Int

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

      RoundedText(text: timeRemaining == 0 ? "Done" : "\(timeRemaining)", style: .callout, weight: .bold)
    }
  }
}
