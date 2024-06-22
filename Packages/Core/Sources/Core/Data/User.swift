import Foundation

public struct User: Hashable, Sendable, Identifiable {
  public let name: String
  public let avatarImageURL: URL

  public var id: String { name }

  public init(name: String, avatarImageURL: URL) {
    self.name = name
    self.avatarImageURL = avatarImageURL
  }
}

extension User {
  public static func mock(
    name: String = "MockUser01",
    avatarImageURL: URL = .init(string: "https://placehold.jp/150x150.png")!
  ) -> Self {
    .init(name: name, avatarImageURL: avatarImageURL)
  }
}
