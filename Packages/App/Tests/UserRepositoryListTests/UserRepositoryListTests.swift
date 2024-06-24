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

  @MainActor
  func testFailureThenRetrySuccess() async {
    let store = TestStore(initialState: UserRepositoryList.State(user: .mock())) {
      UserRepositoryList()
    } withDependencies: {
      $0.userClient.getUser = { @Sendable _ in throw SampleError() }
      $0.userClient.getUserRepositories = { @Sendable _ in throw SampleError() }
    }
    XCTAssertEqual(store.state.contentState, .loading)

    await store.send(.onAppear)
    await store.receive(\.usersResponse) {
      $0.contentState = .failure
    }

    store.dependencies.userClient.getUser = { @Sendable _ in .mock() }
    store.dependencies.userClient.getUserRepositories = { @Sendable _ in [.mock()] }

    await store.send(.retryTapped) {
      $0.contentState = .loading
    }
    await store.receive(\.usersResponse) {
      $0.contentState = .success(.init(user: .mock(), repositories: [.mock()]))
    }
  }
}

private struct SampleError: Error {}
