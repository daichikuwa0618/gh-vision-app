import SwiftUI

public struct AvatarIconView: View {
  let avatarImageURL: URL

  public init(avatarImageURL: URL) {
    self.avatarImageURL = avatarImageURL
  }

  public var body: some View {
    AsyncImage(url: avatarImageURL) { image in
      image.resizable()
    } placeholder: {
      ProgressView()
    }
    .clipShape(Circle())
    .overlay {
      Circle()
        .stroke(Color.green, lineWidth: 2)
    }
    .shadow(color: .green.opacity(0.4), radius: 8, y: 2)
  }
}

#Preview {
  AvatarIconView(
    avatarImageURL: URL(string: "https://placehold.jp/150x150.png")!
  )
}
