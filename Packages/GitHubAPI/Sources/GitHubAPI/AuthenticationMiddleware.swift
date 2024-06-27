import OpenAPIRuntime
import Foundation
import HTTPTypes

struct AuthenticationMiddleware: ClientMiddleware {
  private let value: String

  init(authorizationHeaderFieldValue value: String) {
    self.value = value
  }

  func intercept(
    _ request: HTTPRequest,
    body: HTTPBody?,
    baseURL: URL,
    operationID: String,
    next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
  ) async throws -> (HTTPResponse, HTTPBody?) {
    var request = request
    request.headerFields[.authorization] = value
    return try await next(request, body, baseURL)
  }
}
