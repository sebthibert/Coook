import SwiftUI

struct StepsView: View {
  let viewModel: TimersViewModel
  let stepLists: [Recipe.StepList]
  @Binding var showingSheet: Bool

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      RoundedText(text: "Method", style: .callout, weight: .bold)
      ForEach(stepLists) { stepList in
        VStack(alignment: .leading, spacing: 16) {
          if let title = stepList.title, !title.isEmpty {
            RoundedText(text: title, style: .footnote, weight: .regular)
          }
          ForEach(stepList.stepsWithTimers) { step in
            if let position = step.position, let instructions = step.instructions {
              HStack(alignment: .top) {
                RoundedText(text: String(position), style: .footnote, weight: .bold)
                RoundedText(text: instructions, style: .footnote, weight: .regular)
                if step.hasTimer {
                  Spacer()
                  Button(action: {
                    viewModel.timers.append(TimersViewModel.Timer(instructions: step.instructions, totalSeconds: step.totalTime, dateInitiated: Date()))
                    showingSheet.toggle()
                  }, label: {
                    Image(systemName: "timer")
                  })
                }
              }
              Divider()
            }
          }
        }
      }
    }
  }
}
