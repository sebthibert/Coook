import SwiftUI

struct StepVStack: View {
  let step: Recipe.StepList.StepWithTimer
  @State var showTimer = false
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  @State var timeRemaining: Int = 0

  var body: some View {
    VStack {
      if let instruction = step.instructions {
        RoundedText(text: instruction, style: .title3, weight: .medium)
          .padding()
      }
      if step.hasTimer && showTimer == false {
        Button(action: {
          showTimer = true
          timeRemaining = step.totalTime
        }, label: {
          Image(systemName: "timer")
            .resizable()
        })
        .frame(width: 75, height: 75)
      }
      if showTimer {
        ProgressBar(totalTime: step.totalTime, timeRemaining: timeRemaining)
          .frame(width: 75, height: 75)
      }
    }
    .onReceive(timer) { time in
      if self.timeRemaining > 0 {
        self.timeRemaining -= 1
      }
    }
  }
}
