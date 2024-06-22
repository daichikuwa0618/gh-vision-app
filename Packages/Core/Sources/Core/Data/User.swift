import Foundation

public struct User {
  public let name: String
  public let avatarImageURL: URL

  public init(name: String, avatarImageURL: URL) {
    self.name = name
    self.avatarImageURL = avatarImageURL
  }
}
