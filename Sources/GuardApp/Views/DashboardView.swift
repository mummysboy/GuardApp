import SwiftUI

struct DashboardView: View {
    let claims: UserClaims

    var body: some View {
        switch claims.role {
        case .admin:
            AdminTabView(claims: claims)
        case .businessOwner, .businessStaff:
            BusinessTabView(claims: claims)
        case .worker:
            WorkerTabView(claims: claims)
        }
    }
}