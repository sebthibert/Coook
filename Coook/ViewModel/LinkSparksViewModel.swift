import SwiftUI

class LinkSparksViewModel: ObservableObject {
  private let deepLink = URL(string: "mandsapp://joinsparks")!
  private let webURL = URL(string: "https://www.marksandspencer.com/joinsparks")!

  func joinSparks() {
    launchSparks()
  }

  func connectSparks() {
    launchSparks()
  }

  private func launchSparks() {
    if UIApplication.shared.canOpenURL(deepLink) {
      UIApplication.shared.open(deepLink, options: [:], completionHandler: nil)
    } else {
      UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
    }
  }
}
