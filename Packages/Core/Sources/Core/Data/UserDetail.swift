import Foundation

public struct UserDetail: Hashable, Sendable {
  public let name: String
  public let fullName: String
  public let avatarImageURL: URL
  public let followerCount: Int
  public let followingCount: Int

  public init(
    name: String,
    fullName: String,
    avatarImageURL: URL,
    followerCount: Int,
    followingCount: Int
  ) {
    self.name = name
    self.fullName = fullName
    self.avatarImageURL = avatarImageURL
    self.followerCount = followerCount
    self.followingCount = followingCount
  }
}

extension UserDetail {
  public static func mock(
    name: String = "MockUser01",
    fullName: String = "Mock User",
    avatarImageURL: URL = .init(string: "https://placehold.jp/150x150.png")!,
    followerCount: Int = 0,
    followingCount: Int = 1
  ) -> Self {
    .init(
      name: name,
      fullName: fullName,
      avatarImageURL: avatarImageURL,
      followerCount: followerCount,
      followingCount: followingCount
    )
  }
}
