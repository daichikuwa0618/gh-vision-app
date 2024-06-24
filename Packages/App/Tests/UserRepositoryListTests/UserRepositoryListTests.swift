import CommonUI
import ComposableArchitecture
import Core
import XCTest

@testable import UserRepositoryList

final class UserRepositoryListTests: XCTestCase {
  @MainActor
  func testOnAppear() async {
    let results: [(Result<Content, Error>, AsyncLoadingState<Content>)] = [
      (.success(.init(user: .mock(), repositories: [.mock()])), .success(.init(user: .mock(), repositories: [.mock()]))),
      (.failure(SampleError()), .failure),
    ]

    for result in results {
      let store = TestStore(initialState: UserRepositoryList.State(user: .mock())) {
        UserRepositoryList()
      } withDependencies: {
        $0.userClient.getUser = { @Sendable _ in try result.0.get().user }
        $0.userClient.getUserRepositories = { @Sendable _ in try result.0.get().repositories }
      }
      XCTAssertEqual(store.state.contentState, .loading)

      await store.send(.onAppear)
      await store.receive(\.usersResponse) {
        $0.contentState = result.1
      }
    }
  }
}

private struct SampleError: Error {}
