import Foundation
import Security

protocol AuthService: AuthTokenProvider {
    func restoreSession() async throws -> UserClaims?
    func login(username: String, password: String) async throws -> UserClaims
    func logout() async throws
}

protocol AuthTokenProvider: AnyObject {
    var currentAccessToken: String? { get }
}

final class DefaultAuthService: AuthService {
    static let shared = DefaultAuthService()
    private init() {}

    private(set) var currentAccessToken: String? = nil
    private let keychain = Keychain()

    func restoreSession() async throws -> UserClaims? {
        if let token: String = keychain.get("access_token"),
           let claimsData: Data = keychain.getData("claims"),
           let claims = try? JSONDecoder().decode(UserClaims.self, from: claimsData) {
            currentAccessToken = token
            return claims
        }
        return nil
    }

    func login(username: String, password: String) async throws -> UserClaims {
        // TODO: replace with real API call and token exchange
    let mockClaims = UserClaims(userId: "u_123", tenantId: "t_abc", role: .admin, issuedAt: Date(), expiresAt: Date().addingTimeInterval(3600))
        let mockToken = "mock.jwt.token"
        currentAccessToken = mockToken
        keychain.set(mockToken, forKey: "access_token")
        keychain.set(try JSONEncoder().encode(mockClaims), forKey: "claims")
        return mockClaims
    }

    func logout() async throws {
        currentAccessToken = nil
        keychain.delete("access_token")
        keychain.delete("claims")
    }
}

final class Keychain {
    func set(_ value: String, forKey key: String) {
        guard let data = value.data(using: .utf8) else { return }
        set(data, forKey: key)
    }
    func set(_ data: Data, forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    func get(_ key: String) -> String? {
        guard let data: Data = getData(key) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    func getData(_ key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess, let data = item as? Data else { return nil }
        return data
    }
    func delete(_ key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
