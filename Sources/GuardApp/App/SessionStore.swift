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
            // Force logout on app launch for testing: clear any old session
            try? await auth.logout()
            state = .unauthenticated
        } catch {
            state = .unauthenticated
        }
    }

    @MainActor
    func login(username: String, password: String) async {
        do {
            let claims = try await auth.login(username: username, password: password)
            state = .authenticated(claims)
        } catch {
            // TODO: handle error state
            state = .unauthenticated
        }
    }

    @MainActor
    func logout() async {
        try? await auth.logout()
        state = .unauthenticated
    }
}
