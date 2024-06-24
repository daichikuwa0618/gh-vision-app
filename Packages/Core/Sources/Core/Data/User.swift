import Foundation

public struct User: Hashable, Sendable, Identifiable {
  public let id: Int
  public let name: String
  public let avatarImageURL: URL

  public init(id: Int, name: String, avatarImageURL: URL) {
    self.id = id
    self.name = name
    self.avatarImageURL = avatarImageURL
  }
}

extension User {
  public static func mock(
    id: Int = 1,
    name: String = "MockUser01",
    avatarImageURL: URL = .init(string: "https://placehold.jp/150x150.png")!
  ) -> Self {
    .init(id: id, name: name, avatarImageURL: avatarImageURL)
  }
}
