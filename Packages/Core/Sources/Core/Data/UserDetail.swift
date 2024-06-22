import Foundation

public struct UserDetail {
  public let name: String
  public let fullName: String
  public let avatarImageURL: URL
  public let followerCount: Int
  public let followingCount: Int

  public init(name: String, fullName: String, avatarImageURL: URL, followerCount: Int, followingCount: Int) {
    self.name = name
    self.fullName = fullName
    self.avatarImageURL = avatarImageURL
    self.followerCount = followerCount
    self.followingCount = followingCount
  }
}
