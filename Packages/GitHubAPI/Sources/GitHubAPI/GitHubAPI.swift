import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

@main
struct GitHubClient {
  static func main() async throws {
    let client: Client = .init(serverURL: URL(string: "")!, transport: URLSessionTransport())
    let hoge = try await client.users_sol_list(.init())
  }
}
