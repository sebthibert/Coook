import SwiftUI

struct RecipeView: View {
  let viewModel: RecipeViewModel
  @State private var showingTimerSheet = false
  @State var isFavourited: Bool = false
  @State var showShareSheet = false

  var loadingImage: LoadingImage {
    LoadingImage(imageSize: nil, cornerRadius: 0, viewModel: viewModel.loadingImageViewModel)
  }

  var body: some View {
    ScrollView {
      VStack {
        loadingImage
          .scaledToFill()
        VStack(alignment: .leading, spacing: 32) {
          if let title = viewModel.recipe.title {
            RoundedText(text: title, style: .largeTitle, weight: .heavy)
          }
          if let summary = viewModel.recipe.summary, !summary.isEmpty {
            RoundedText(text: summary, style: .callout, weight: .regular)
          }
          if let ingredientLists = viewModel.recipe.ingredientListsWithIngredients {
            IngredientsView(recipe: viewModel.recipe, isEditable: false, ingredientLists: ingredientLists)
          }
          if let stepLists = viewModel.recipe.recipeStepListsWithSteps {
            StepsView(viewModel: viewModel.timersViewModel, stepLists: stepLists, loadingImage: loadingImage, showingTimerSheet: $showingTimerSheet)
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
        showShareSheet.toggle()
      }, label: {
        Image(systemName: "square.and.arrow.up")
      })
        .shareSheet(showShareSheet: $showShareSheet, items: [viewModel.shareString])
      Button(action: {
        showingTimerSheet.toggle()
      }, label: {
        Image(systemName: "timer")
      })
    }
                          .sheet(isPresented: $showingTimerSheet) {
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
