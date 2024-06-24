import CommonUI
import Core
import SwiftUI

struct UserRow: View {
  let user: User

  var body: some View {
    HStack {
      AvatarIconView(avatarImageURL: user.avatarImageURL)
        .frame(width: 40, height: 40)

      Text(user.name)
    }
  }
}

#Preview {
  UserRow(user: .mock())
}
