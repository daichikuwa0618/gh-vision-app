import Dependencies
import DependenciesMacros
import Foundation

@DependencyClient
public struct UserClient: Sendable {
  public var getUsers: @Sendable () async throws -> [User]
  public var getUser: @Sendable (_ id: Int) async throws -> UserDetail
  public var getUserRepositories: @Sendable (_ userName: String) async throws -> [Repository]
}

extension UserClient: TestDependencyKey {
  public static var previewValue: Self {
    .init(
      getUsers: {
        try await Task.sleep(nanoseconds: NSEC_PER_SEC)
        return (0..<20).map { .mock(id: $0, name: "MockUser\($0)") }
      },
      getUser: { _ in
        try await Task.sleep(nanoseconds: NSEC_PER_SEC)
        return .mock()
      },
      getUserRepositories: { _ in
        try await Task.sleep(nanoseconds: NSEC_PER_SEC)
        return (0..<20).map { .mock(id: $0, name: "mock-repository-\($0)") }
      }
    )
  }

  public static var testValue = Self.init()
}

extension DependencyValues {
  public var userClient: UserClient {
    get { self[UserClient.self] }
    set { self[UserClient.self] = newValue }
  }
}
