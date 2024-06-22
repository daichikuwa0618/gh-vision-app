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
