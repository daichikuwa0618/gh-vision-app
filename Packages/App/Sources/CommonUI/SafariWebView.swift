import SafariServices
import SwiftUI

public struct SafariWebView: UIViewControllerRepresentable {
  let url: URL

  public init(url: URL) {
    self.url = url
  }

  public func makeUIViewController(context: Context) -> SFSafariViewController {
    SFSafariViewController(url: url)
  }

  public func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
  }
}

#Preview {
  SafariWebView(url: URL(string: "https://apple.com")!)
    .ignoresSafeArea()
}
