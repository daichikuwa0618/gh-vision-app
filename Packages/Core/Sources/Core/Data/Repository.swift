import Foundation

public struct Repository: Hashable, Sendable, Identifiable {
  public let id: Int
  public let name: String
  public let language: String
  public let starCount: Int
  public let description: String

  public init(id: Int, name: String, language: String, starCount: Int, description: String) {
    self.id = id
    self.name = name
    self.language = language
    self.starCount = starCount
    self.description = description
  }
}

extension Repository {
  public static func mock(
    id: Int = 1,
    name: String = "mock-repository",
    language: String = "Swift",
    starCount: Int = 0,
    description: String = "This is mock repository"
  ) -> Self {
    .init(id: id, name: name, language: language, starCount: starCount, description: description)
  }
}
