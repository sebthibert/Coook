import SwiftUI

struct FocusedView: View {
  let stepLists: [Recipe.StepList]
  let loadingImage: LoadingImage
  @Environment(\.presentationMode) var presentationMode

  var body: some View {
    ZStack {
      TabView {
        if stepLists.count > 1 {
          ForEach(stepLists) { stepList in
            RoundedText(text: stepList.focusedTitle, style: .title, weight: .bold)
              .padding()
            ForEach(stepList.stepsWithTimers) { step in
              StepVStack(step: step)
            }
          }
        } else {
          if let stepList = stepLists.first {
            ForEach(stepList.stepsWithTimers) { step in
              StepVStack(step: step)
            }
          }
        }
      }
      .background(loadingImage
                    .scaledToFill()
                    .opacity(0.2)
                    .ignoresSafeArea()
      )
      VStack {
        HStack {
          Button {
            presentationMode.wrappedValue.dismiss()
          } label: {
            RoundedText(text: "Close", style: .body, weight: .heavy)
          }
          .padding()
          Spacer()
        }
        Spacer()
      }
    }
    .background(Color(.systemGroupedBackground))
    .environment(\.colorScheme, .dark)
    .preferredColorScheme(.dark)
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
}
