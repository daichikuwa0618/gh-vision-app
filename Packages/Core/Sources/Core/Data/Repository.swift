import Foundation

public struct Repository {
  public let name: String
  public let language: String
  public let starCount: Int
  public let description: String

  public init(name: String, language: String, starCount: Int, description: String) {
    self.name = name
    self.language = language
    self.starCount = starCount
    self.description = description
  }
}

extension Repository {
  public static func mock(
    name: String = "mock-repository",
    language: String = "Swift",
    starCount: Int = 0,
    description: String = "This is mock repository"
  ) -> Self {
    .init(name: name, language: language, starCount: starCount, description: description)
  }
}
