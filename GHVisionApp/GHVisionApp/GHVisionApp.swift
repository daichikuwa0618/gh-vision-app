import ComposableArchitecture
import GitHubAPI
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
          Root().transformDependency(\.self) { dependency in
            // Optional: Put your GitHub PAT here to avoid API rate limit.
            let gitHubPAT: String? = nil
            dependency.userClient = .live(token: gitHubPAT)
          }
        }
      )
    }
  }
}
