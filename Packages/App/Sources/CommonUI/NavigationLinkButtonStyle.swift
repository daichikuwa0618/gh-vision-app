import SwiftUI

public struct NavigationLinkButtonStyle: PrimitiveButtonStyle {
  public func makeBody(configuration: Configuration) -> some View {
    Button(action: configuration.trigger) {
      HStack {
        configuration.label
          .frame(maxWidth: .infinity, alignment: .leading)

        Image(systemName: "chevron.right")
          .font(Font.system(size: 14, weight: .semibold))
          .foregroundColor(.secondary)
          .opacity(0.5)
      }
    }
  }
}

extension PrimitiveButtonStyle where Self == NavigationLinkButtonStyle {
  public static var navigationLink: Self { .init() }
}
