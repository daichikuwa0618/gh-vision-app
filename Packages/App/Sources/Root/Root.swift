import ComposableArchitecture
import SwiftUI
import UserList
import UserRepositoryList

@Reducer
public struct Root {
  @Reducer
  public enum Path {
    case userRepositoryList(UserRepositoryList)
  }

  @ObservableState
  public struct State {
    var userList: UserList.State = .init()
    var path = StackState<Path.State>()

    public init() {}
  }

  public enum Action {
    case userList(UserList.Action)
    case path(StackActionOf<Path>)
  }

  public var body: some ReducerOf<Self> {
    Scope(state: \.userList, action: \.userList) {
      UserList()
    }

    Reduce<State, Action> { state, action in
      switch action {
      case let .userList(.delegate(.userTapped(user))):
        state.path.append(.userRepositoryList(.init(user: user)))
        return .none

      case .userList, .path:
        return .none
      }
    }
    .forEach(\.path, action: \.path)
  }

  public init() {}
}

public struct RootScreen: View {
  @Perception.Bindable var store: StoreOf<Root>

  public init(store: StoreOf<Root>) {
    self.store = store
  }

  public var body: some View {
    WithPerceptionTracking {
      NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
        UserListScreen(store: store.scope(state: \.userList, action: \.userList))
      } destination: { store in
        WithPerceptionTracking {
          switch store.case {
          case let .userRepositoryList(store):
            UserRepositoryListScreen(store: store)
          }
        }
      }
    }
  }
}
