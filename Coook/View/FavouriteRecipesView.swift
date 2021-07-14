import SwiftUI

struct FavouriteRecipesView: View {
  let favouriteRecipes = UserDefaults.getAllRecipes()
  var body: some View {
    VStack {
      HStack(alignment: .center) {
        RoundedText(text: "Favourite Recipes", style: .title3, weight: .bold)
        Spacer()
        NavigationLink(destination: CollectionView(viewModel: FavouriteRecipesViewModel(recipes: favouriteRecipes))) {
          RoundedText(text: "See all", style: .callout, weight: .bold)
        }
      }
      ScrollView(.horizontal) {
        LazyHGrid(rows: [GridItem(alignment: .top)]) {
          ForEach(favouriteRecipes.prefix(5)) { recipe in
            let viewModel = RecipeViewModel(recipe: recipe)
            RecipeGridItem(viewModel: viewModel)
              .frame(width: 200)
              .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
          }
        }
      }
    }
  }
}
