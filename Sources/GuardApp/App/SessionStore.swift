import Foundation
import SwiftUI

final class SessionStore: ObservableObject {
    enum State {
        case loading
        case unauthenticated
        case authenticated(UserClaims)
    }

    @Published private(set) var state: State = .loading
    private let auth: AuthService = DefaultAuthService.shared

    var claims: UserClaims? {
        if case .authenticated(let c) = state { return c } else { return nil }
    }

    @MainActor
    func bootstrap() async {
        do {
            if let claims = try await auth.restoreSession() {
                state = .authenticated(claims)
            } else {
                state = .unauthenticated
            }
        } catch {
            print("Failed to restore session: \(error)")
            state = .unauthenticated
        }
    }

    @MainActor
    func login(username: String, password: String) async {
        do {
            let claims = try await auth.login(username: username, password: password)
            state = .authenticated(claims)
        } catch {
            print("Login failed: \(error)")
            // Keep the user in unauthenticated state on login failure
            state = .unauthenticated
        }
    }

    @MainActor
    func logout() async {
        do {
            try await auth.logout()
        } catch {
            print("Logout error: \(error)")
        }
        state = .unauthenticated
    }
}
