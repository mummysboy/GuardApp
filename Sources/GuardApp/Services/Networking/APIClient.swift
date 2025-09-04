import Foundation

struct AppEnvironment {
    static var baseURL: URL = {
        if let urlStr = ProcessInfo.processInfo.environment["BASE_URL"], let url = URL(string: urlStr) {
            return url
        }
        return URL(string: "https://api.dev.example.com")!
    }()
}

protocol APIClient {
    func get<T: Decodable>(_ path: String, query: [URLQueryItem]?) async throws -> T
    func post<T: Decodable, U: Encodable>(_ path: String, body: U, idempotencyKey: String?) async throws -> T
}

final class DefaultAPIClient: APIClient {
    private let session: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.timeoutIntervalForRequest = 15
        config.timeoutIntervalForResource = 30
        return URLSession(configuration: config)
    }()

    private var auth: AuthTokenProvider { DefaultAuthService.shared }

    func get<T: Decodable>(_ path: String, query: [URLQueryItem]?) async throws -> T {
        var comps = URLComponents(url: AppEnvironment.baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        comps.queryItems = query
        var req = URLRequest(url: comps.url!)
        req.httpMethod = "GET"
        attachAuth(&req)
        let (data, resp) = try await session.data(for: req)
        try Self.validate(resp: resp, data: data)
        return try JSONDecoder().decode(T.self, from: data)
    }

    func post<T: Decodable, U: Encodable>(_ path: String, body: U, idempotencyKey: String? = nil) async throws -> T {
        var req = URLRequest(url: AppEnvironment.baseURL.appendingPathComponent(path))
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let key = idempotencyKey { req.setValue(key, forHTTPHeaderField: "Idempotency-Key") }
        attachAuth(&req)
        req.httpBody = try JSONEncoder().encode(body)
        let (data, resp) = try await session.data(for: req)
        try Self.validate(resp: resp, data: data)
        return try JSONDecoder().decode(T.self, from: data)
    }

    private func attachAuth(_ req: inout URLRequest) {
        if let token = auth.currentAccessToken {
            req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }

    private static func validate(resp: URLResponse, data: Data) throws {
        guard let http = resp as? HTTPURLResponse else { throw URLError(.badServerResponse) }
        guard (200...299).contains(http.statusCode) else {
            throw NSError(domain: "API", code: http.statusCode, userInfo: [NSLocalizedDescriptionKey: String(data: data, encoding: .utf8) ?? "HTTP \(http.statusCode)"])
        }
    }
}