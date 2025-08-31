import SwiftUI

struct AdminTabView: View {
    let claims: UserClaims

    var body: some View {
        TabView {
            AdminHomeView()
                .tabItem { Label("Home", systemImage: "shield") }
            TenantsView()
                .tabItem { Label("Tenants", systemImage: "building.2") }
            AuditsView()
                .tabItem { Label("Audits", systemImage: "doc.text.magnifyingglass") }
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape") }
        }
    }
}

struct AdminHomeView: View {
    var body: some View { Text("Admin Home") }
}
struct TenantsView: View { var body: some View { Text("Manage Tenants") } }
struct AuditsView: View { var body: some View { Text("Audit Logs") } }
struct SettingsView: View { var body: some View { Text("Global Settings") } }