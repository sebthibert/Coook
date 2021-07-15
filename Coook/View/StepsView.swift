import SwiftUI

struct StepsView: View {
  let viewModel: TimersViewModel
  let stepLists: [Recipe.StepList]
  let loadingImage: LoadingImage
  @Binding var showingTimerSheet: Bool
  @State private var showingFocusSheet = false

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      HStack {
        RoundedText(text: "Method", style: .callout, weight: .bold)
        Spacer()
        Button(action: {
          showingFocusSheet = true
        }, label: {
          Image(systemName: "eyeglasses")
        })
          .fullScreenCover(isPresented: $showingFocusSheet) {
            FocusedView(stepLists: stepLists, loadingImage: loadingImage)
          }
      }
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
                    showingTimerSheet.toggle()
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
