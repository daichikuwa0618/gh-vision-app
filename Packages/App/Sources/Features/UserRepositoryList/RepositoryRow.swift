import Core
import SwiftUI

struct RepositoryRow: View {
  let repository: Repository

  var body: some View {
    VStack(alignment: .leading) {
      Text(repository.name)
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)

      HStack {
        Image(systemName: "star.fill")
          .foregroundStyle(.yellow)

        Text("\(repository.starCount)")

        if let language = repository.language {
          Text("/")

          Text(language)
        }
      }

      if let description = repository.description {
        Text(description)
          .font(.caption)
          .foregroundStyle(.secondary)
      }
    }
    .multilineTextAlignment(.leading)
  }
}

#Preview {
  RepositoryRow(repository: .mock())
}
