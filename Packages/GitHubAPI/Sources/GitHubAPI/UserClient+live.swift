import Core
import Dependencies
import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

extension UserClient: DependencyKey {
  public static var liveValue: UserClient {
    let client = Client(
      serverURL: URL(string: "https://api.github.com")!,
      transport: URLSessionTransport()
    )

    return .init(
      getUsers: {
        let users = try await client.users_sol_list(headers: .init(accept: [.init(contentType: .json)]))
        return try users.ok.body.json.map { user in
          let avatarImageURL = URL(string: user.avatar_url)
          return .init(id: user.id, name: user.login, avatarImageURL: avatarImageURL!)
        }
      },
      getUser: { id in
        let response = try await client.users_sol_get_hyphen_by_hyphen_username(
          path: .init(username: "\(id)"),
          headers: .init(accept: [.init(contentType: .json)])
        )
        let json = try response.ok.body.json
        switch json {
        case let .private_hyphen_user(user):
          let avatarImageURL = URL(string: user.avatar_url)
          return .init(
            name: user.login,
            fullName: user.name ?? "nil",
            avatarImageURL: avatarImageURL!,
            followerCount: user.followers,
            followingCount: user.following
          )
        case let .public_hyphen_user(user):
          let avatarImageURL = URL(string: user.avatar_url)
          return .init(
            name: user.login,
            fullName: user.name ?? "nil",
            avatarImageURL: avatarImageURL!,
            followerCount: user.followers,
            followingCount: user.following
          )
        }
      },
      getUserRepositories: { id in
        let response = try await client.repos_sol_list_hyphen_for_hyphen_user(
          .init(
            path: .init(username: "\(id)"),
            query: .init(_type: .owner, sort: .updated, per_page: 20),
            headers: .init(accept: [.init(contentType: .json)])
          )
        )
        return try response.ok.body.json
          .filter { !$0.fork }
          .map { repository in
            // TODO: model の optional を改める
            Repository(
              id: repository.id,
              name: repository.name,
              language: repository.language ?? "nil lang",
              starCount: repository.stargazers_count ?? 0,
              description: repository.description ?? "null desc"
            )
          }
      }
    )
  }
}
