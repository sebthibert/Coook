import SwiftUI

struct ProfileView: View {
  @ObservedObject var viewModel: ProfileViewModel

  var body: some View {
    Text("Hello, Seb!")
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView(viewModel: ProfileViewModel())
  }
}
