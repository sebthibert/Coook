import SwiftUI

struct RecipeView: View {
  let viewModel: RecipeViewModel
  @State private var showingSheet = false
  @State var isFavourited: Bool = false

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
      isFavourited = UserDefaults.isRecipeFavourited(viewModel.recipe)
      viewModel.loadingImageViewModel.getImage(path: viewModel.recipe.photo?.urls?.medium)
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarItems(trailing:
                          HStack {
      Button(action: {
        toggleFavourite()
      }, label: {
        Image(systemName: isFavourited ? "heart.fill" : "heart")
      })
      Button(action: {
        showingSheet.toggle()
      }, label: {
        Image(systemName: "timer")
      })
    }
                          .sheet(isPresented: $showingSheet) {
      TimersView(viewModel: viewModel)
    }
    )
  }

  func toggleFavourite() {
    if UserDefaults.isRecipeFavourited(viewModel.recipe) {
      UserDefaults.removeFavourite(recipe: viewModel.recipe)
      isFavourited = false
    } else {
      UserDefaults.setFavourite(recipe: viewModel.recipe)
      isFavourited = true
    }
  }
}
