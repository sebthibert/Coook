import SwiftUI

struct ProfileView: View {
  var body: some View {
    ScrollView {
      VStack {
        FavouriteRecipesView()
          .padding()
      }
    }
    .background(Color(.systemGroupedBackground))
    .navigationBarTitle("Profile")
  }
}
