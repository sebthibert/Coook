import CoreSpotlight
import MobileCoreServices
import SwiftUI

struct RecipeView: View {
  let viewModel: RecipeViewModel
  @State private var showingTimerSheet = false
  @State var isFavourited: Bool = false
  @State var showShareSheet = false
  @State private var showARView = false

  var loadingImage: LoadingImage {
    LoadingImage(imageSize: nil, cornerRadius: 0, viewModel: viewModel.loadingImageViewModel)
  }

  var body: some View {
    ScrollView {
      VStack {
        loadingImage
          .scaledToFill()
        
        if viewModel.recipe.usdz != nil{
          Button {
            showARView.toggle()
          } label: {
            HStack {
              Spacer()
              RoundedText(text: "View in AR", style: .callout, weight: .bold)
              Image(systemName: "arkit")
            }
            .padding()
          }
        }
        
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
      spotlightIndex()
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
      if viewModel.hasTimers {
        Button(action: {
          showingTimerSheet.toggle()
        }, label: {
          Image(systemName: "timer")
        })
      }
    }
                          .sheet(isPresented: $showingTimerSheet) {
      TimersView(viewModel: viewModel)
    }
    )
    .fullScreenCover(isPresented: $showARView, content: ARView.init)
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

  func spotlightIndex() {
    let attributeSet = CSSearchableItemAttributeSet(itemContentType: "UTTypeText")
    attributeSet.title = viewModel.recipe.title
    attributeSet.contentDescription = viewModel.recipe.summary ?? "Get cooking with this simple easy delicious recipe!"
    attributeSet.thumbnailData = viewModel.loadingImageViewModel.imageData

    let item = CSSearchableItem(uniqueIdentifier: String(viewModel.recipe.id), domainIdentifier: "com.coook", attributeSet: attributeSet)
    CSSearchableIndex.default().indexSearchableItems([item]) { error in
      if let error = error {
        print("Indexing error: \(error.localizedDescription)")
      } else {
        print("Search item successfully indexed!")
      }
    }
  }
}
