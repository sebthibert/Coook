import SwiftUI

struct Collection: Codable, Identifiable {
  let id: Int
  let title: String?
  let description: String?
  let slug: String?
  let position: Int?
  let featured: Bool?
  let img: Image?
  let hidden: Bool?
  let recipes: [Int]?

  var trimmedDescription: String? {
    description?.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  struct Image: Codable {
    let urls: ImageURLs?
    let width: Int?
    let height: Int?
  }

  struct ImageURLs: Codable {
    let tiny: String?
    let small: String?
    let medium: String?
    let large: String?

    enum CodingKeys: String, CodingKey {
      case tiny = "160"
      case small = "320"
      case medium = "640"
      case large = "1280"
    }
  }
}
