import SwiftUI

struct LinkSparksView: View {
  @ObservedObject var viewModel: LinkSparksViewModel

  var body: some View {
    VStack {
      Image(uiImage: UIImage(named: "sparksBg")!)
        .resizable()
        .scaledToFill()
        .ignoresSafeArea(.container, edges: [.top])
      RoundedText(text: "Connect your Sparks account", style: .title2, weight: .bold)
      RoundedText(text: "Link your Sparks account to get exclusive food offers and the best recipes", style: .body, weight: .regular)
        .padding()
        .multilineTextAlignment(.center)
      Spacer()
      GeometryReader { proxy in
        VStack {
          connectButton.frame(width: proxy.size.width)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
          joinButton
            .frame(width: proxy.size.width)
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 1)
            )
        }
      }
      .padding()
    }
    .offset(y: -50)
  }

  var connectButton: some View {
    Button {
      viewModel.connectSparks()
    } label: {
      RoundedText(text: "Connect", style: .body, weight: .bold)
        .foregroundColor(.white)
    }
    .padding()
    .contentShape(Rectangle())
    .frame(height: 50)
  }

  var joinButton: some View {
    Button {
      viewModel.joinSparks()
    } label: {
      RoundedText(text: "Not a member? Join Sparks", style: .body, weight: .regular)
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
