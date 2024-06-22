import CommonUI
import ComposableArchitecture
import Core
import SwiftUI

@Reducer
public struct UserList {
  @ObservableState
  public struct State: Equatable {
    var contentState: AsyncLoadingState<[User]> = .loading
  }

  public enum Action {
    case onAppear
    case usersResponse(Result<[User], Error>)
  }

  public var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .run { send in
          let users = try await userClient.getUsers()
          await send(.usersResponse(.success(users)))
        } catch: { error, send in
          await send(.usersResponse(.failure(error)))
        }

      case let .usersResponse(result):
        switch result {
        case let .success(users):
          state.contentState = .success(users)
          return .none

        case .failure:
          state.contentState = .failure
          return .none
        }
      }
    }
  }

  @Dependency(\.userClient) var userClient

  public init() {}
}

public struct UserListScreen: View {
  let store: StoreOf<UserList>

  public init(store: StoreOf<UserList>) {
    self.store = store
  }

  public var body: some View {
    WithPerceptionTracking {
      AsyncContentView(state: store.contentState) { users in
        List {
          ForEach(users) { user in
            WithPerceptionTracking {
              Text(user.name)
            }
          }
        }
      }
    }
    .task {
      await store.send(.onAppear).finish()
    }
  }
}

#Preview {
  NavigationStack {
    UserListScreen(store: .init(initialState: UserList.State()) {
      UserList()
    })
  }
}
