import CommonUI
import ComposableArchitecture
import Core
import XCTest

@testable import UserList

final class UserListTests: XCTestCase {
  @MainActor
  func testOnAppear() async {
    let results: [(Result<[User], Error>, AsyncLoadingState<[User]>)] = [
      (.success([.mock()]), .success([.mock()])),
      (.failure(SampleError()), .failure),
    ]

    for result in results {
      let store = TestStore(initialState: UserList.State()) {
        UserList()
      } withDependencies: {
        $0.userClient.getUsers = { try result.0.get() }
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
    let store = TestStore(initialState: UserList.State()) {
      UserList()
    } withDependencies: {
      $0.userClient.getUsers = { throw SampleError() }
    }
    XCTAssertEqual(store.state.contentState, .loading)

    await store.send(.onAppear)
    await store.receive(\.usersResponse) {
      $0.contentState = .failure
    }

    store.dependencies.userClient.getUsers = { [.mock()] }

    await store.send(.retryTapped) {
      $0.contentState = .loading
    }
    await store.receive(\.usersResponse) {
      $0.contentState = .success([.mock()])
    }
  }
}

private struct SampleError: Error {}
