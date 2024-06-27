import CommonUI
import Core
import SwiftUI

struct HeaderUserView: View {
  let user: UserDetail

  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      AvatarIconView(avatarImageURL: user.avatarImageURL)
        .frame(width: 80, height: 80)

      VStack(alignment: .leading) {
        if let fullName = user.fullName {
          Text(fullName)
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        Text(user.name)
          .foregroundStyle(.secondary)
          .monospaced()
          .frame(maxWidth: .infinity, alignment: .leading)

        HStack(spacing: 4) {
          Image(systemName: "person.2")
            .foregroundStyle(.secondary)
            .padding(.trailing, 4)

          Text("**\(user.followerCount)** followers")

          Text("/")

          Text("**\(user.followingCount)** followings")
        }
        .font(.caption)
        .padding(.top, 8)
      }
    }
  }
}

#Preview {
  HeaderUserView(user: .mock())
}
