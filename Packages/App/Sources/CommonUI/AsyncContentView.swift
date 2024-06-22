import SwiftUI

public enum AsyncLoadingState<T> {
  case loading
  case success(T)
  case failure
}

public struct AsyncContentView<T, Success: View>: View {
  let state: AsyncLoadingState<T>
  let success: (T) -> Success
  let onTapRetry: (() -> Void)?

  public init(
    state: AsyncLoadingState<T>,
    @ViewBuilder success: @escaping (T) -> Success,
    retries: (() -> Void)? = nil
  ) {
    self.state = state
    self.success = success
    self.onTapRetry = retries
  }

  public var body: some View {
    switch state {
    case .loading:
      ProgressView()

    case let .success(data):
      success(data)

    case .failure:
      VStack {
        Image(systemName: "cloud.rain")
          .font(.system(size: 120))
          .foregroundStyle(.cyan.opacity(0.4))

        Text("Something went wrong. Please try again.", bundle: .module)
          .multilineTextAlignment(.center)

        if let onTapRetry {
          Button(action: onTapRetry) {
            Label(
              title: { Text("Retry", bundle: .module) },
              icon: { Image(systemName: "arrow.counterclockwise") }
            )
          }
          .buttonStyle(.bordered)
          .fontWeight(.medium)
        }
      }
      .padding()
    }
  }
}

#Preview("Loading") {
  AsyncContentView(state: AsyncLoadingState<String>.loading) { _ in
    Text("Success")
  }
}

#Preview("Success") {
  AsyncContentView(state: AsyncLoadingState<String>.success("Success")) { data in
    Text(data)
  }
}

#Preview("Failure (w/ retry)") {
  AsyncContentView(state: AsyncLoadingState<String>.failure) { data in
    Text(data)
  } retries: {
    // Do nothing
  }
}

#Preview("Failure (w/o retry)") {
  AsyncContentView(state: AsyncLoadingState<String>.failure) { data in
    Text(data)
  }
}
