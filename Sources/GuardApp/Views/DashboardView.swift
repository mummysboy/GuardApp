import SwiftUI

struct DashboardView: View {
    let claims: UserClaims

    var body: some View {
        switch claims.role {
        case .admin:
            AdminTabView(claims: claims)
        case .supervisor:
            BusinessTabView(claims: claims)
        case .securityGuard:
            WorkerTabView(claims: claims)
        }
    }
}