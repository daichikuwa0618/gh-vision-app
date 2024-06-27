import ComposableArchitecture
import Root
import SwiftUI

@main
struct GHVisionApp: App {
  var body: some Scene {
    WindowGroup {
      RootScreen(
        store: StoreOf<Root>(
          initialState: Root.State()
        ) {
          Root()
        }
      )
    }
  }
}
