import SwiftUI

struct RecipeView: View {
  let viewModel: RecipeViewModel
  @State private var showingSheet = false

  var body: some View {
    ScrollView {
      VStack {
        LoadingImage(imageSize: nil, cornerRadius: 0, viewModel: viewModel.loadingImageViewModel)
          .scaledToFill()
        VStack(alignment: .leading, spacing: 32) {
          if let title = viewModel.recipe.title {
            RoundedText(text: title, style: .largeTitle, weight: .heavy)
          }
          if let summary = viewModel.recipe.summary, !summary.isEmpty {
            RoundedText(text: summary, style: .callout, weight: .regular)
          }
          if let ingredientLists = viewModel.recipe.ingredientListsWithIngredients {
            IngredientsView(ingredientLists: ingredientLists)
          }
          if let stepLists = viewModel.recipe.recipeStepListsWithSteps {
            StepsView(viewModel: viewModel.timersViewModel, stepLists: stepLists, showingSheet: $showingSheet)
          }
        }
        .padding()
      }
    }
    .onAppear {
      viewModel.loadingImageViewModel.getImage(path: viewModel.recipe.photo?.urls?.medium)
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarItems(trailing: Button(action: {
      showingSheet.toggle()
    }, label: {
        Image(systemName: "timer")
    })
                          .sheet(isPresented: $showingSheet) {
      TimersView(viewModel: viewModel)
                          }
    )
  }
}

