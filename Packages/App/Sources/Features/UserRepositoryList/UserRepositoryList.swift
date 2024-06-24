import CommonUI
import ComposableArchitecture
import Core
import SwiftUI

@Reducer
public struct UserRepositoryList {
  @ObservableState
  public struct State: Equatable {
    let user: User
    var contentState: AsyncLoadingState<Content> = .loading

    public init(user: User) {
      self.user = user
    }
  }

  public enum Action {
    case onAppear
    case retryTapped
    case usersResponse(Result<(user: UserDetail, repositories: [Repository]), Error>)
  }

  public var body: some ReducerOf<Self> {
    Reduce<State, Action> {
      state,
      action in
      switch action {
      case .onAppear, .retryTapped:
        state.contentState = .loading
        return .run { [user = state.user] send in
          async let userTask = userClient.getUser(id: user.id)
          async let repositoriesTask = userClient.getUserRepositories(userName: user.name)
          let response = try await (userTask, repositoriesTask)
          await send(.usersResponse(.success(response)))
        } catch: { error, send in
          await send(.usersResponse(.failure(error)))
        }

      case let .usersResponse(result):
        switch result {
        case let .success(response):
          state.contentState = .success(
            .init(
              user: response.user,
              repositories: response.repositories
            )
          )
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

public struct UserRepositoryListScreen: View {
  let store: StoreOf<UserRepositoryList>

  @State private var isHeaderVisible = true

  public init(store: StoreOf<UserRepositoryList>) {
    self.store = store
  }

  public var body: some View {
    WithPerceptionTracking {
      AsyncContentView(state: store.contentState) { content in
        WithPerceptionTracking {
          List {
            Section {
              HeaderUserView(user: content.user)
                .listRowBackground(Color.clear)
                .listRowInsets(.init(top: 8, leading: 8, bottom: 8, trailing: 8))
            }

            Section("Repositories") {
              ForEach(content.repositories) { repository in
                WithPerceptionTracking {
                  RepositoryRow(repository: repository)
                }
              }
            }
          }
        }
      } retries: {
        store.send(.retryTapped)
      }
    }
    .task {
      await store.send(.onAppear).finish()
    }
    .navigationTitle(Text(store.state.user.name))
  }
}

#Preview {
  NavigationStack {
    UserRepositoryListScreen(
      store: .init(
        initialState: UserRepositoryList.State(
          user: .mock()
        ),
        reducer: {
          UserRepositoryList()
        }
      )
    )
  }
}
