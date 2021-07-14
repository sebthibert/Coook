import SwiftUI

struct TimersView: View {
  @ObservedObject var viewModel: RecipeViewModel
  @Environment(\.dismiss) var dismiss

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 32) {
        HStack {
          Spacer()
          Button(
            action: {
            dismiss()
          },
            label: {
            RoundedText(text: "Done", style: .callout, weight: .bold)
          }
          )
        }
        RoundedText(text: viewModel.recipe.title ?? "No title", style: .title, weight: .heavy)
        VStack(alignment: .leading, spacing: 16) {
          ForEach(viewModel.timersViewModel.timers) { timer in
            TimerView(instructions: timer.instructions, totalTime: timer.totalSeconds, timeRemaining: timer.secondsLeft)
            Divider()
          }
        }
      }
      .padding()
    }
  }
}
