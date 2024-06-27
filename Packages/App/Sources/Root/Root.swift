import ComposableArchitecture
import SwiftUI
import UserList
import UserRepositoryList

@Reducer
public struct Root {
  public init() {}
}

public struct RootScreen: View {
  @Perception.Bindable var store: StoreOf<Root>

  public init(store: StoreOf<Root>) {
    self.store = store
  }

  public var body: some View {
    WithPerceptionTracking {
    }
  }
}
