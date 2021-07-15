import SwiftUI

struct LinkSparksView: View {
  @ObservedObject var viewModel: LinkSparksViewModel

  var body: some View {
    VStack {
      Image(uiImage: UIImage(named: "sparksBg")!)
        .resizable()
        .scaledToFill()
        .ignoresSafeArea(.container, edges: [.top])
      Text("Connect your Sparks account")
        .font(.title2)
        .bold()
      Text("Link your Sparks account to get exclusive food offers and the best recipes")
        .font(.body)
        .padding()
        .multilineTextAlignment(.center)
      Spacer()
      GeometryReader { proxy in
        VStack {
          connectButton.frame(width: proxy.size.width)
            .background(.black)
          joinButton
            .frame(width: proxy.size.width)
            .border(.black, width: 2)
        }
      }
      .padding()
    }
    .offset(y: -50)
  }

  var connectButton: some View {
    Button {

    } label: {
      Text("Connect")
        .foregroundColor(.white)
        .bold()
    }
    .padding()
    .contentShape(Rectangle())
    .frame(height: 50)
  }

  var joinButton: some View {
    Button {

    } label: {
      Text("Not a member? Join Sparks")
        .foregroundColor(.black)
    }
    .padding()
    .contentShape(Rectangle())
    .frame(height: 50)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    LinkSparksView(viewModel: LinkSparksViewModel())
  }
}
