import Core
import SwiftUI

struct UserRow: View {
  let user: User

  var body: some View {
    HStack {
      AsyncImage(url: user.avatarImageURL) { image in
        image.resizable()
      } placeholder: {
        ProgressView()
      }
      .frame(width: 40, height: 40)
      .clipShape(Circle())
      .overlay {
        Circle()
          .stroke(Color.green, lineWidth: 2)
      }
      .shadow(color: .green.opacity(0.4), radius: 8, y: 2)

      Text(user.name)
    }
  }
}

#Preview {
  UserRow(user: .mock())
}
