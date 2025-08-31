import SwiftUI

struct WorkerTabView: View {
    let claims: UserClaims

    var body: some View {
        TabView {
            WorkerHomeView()
                .tabItem { Label("Home", systemImage: "person") }
            OpeningsView()
                .tabItem { Label("Openings", systemImage: "list.bullet") }
            MyJobsView()
                .tabItem { Label("My Jobs", systemImage: "checkmark.circle") }
            WalletView()
                .tabItem { Label("Wallet", systemImage: "creditcard") }
        }
    }
}

struct WorkerHomeView: View { var body: some View { Text("Worker Home") } }
struct OpeningsView: View { var body: some View { Text("Open Shifts Near You") } }
struct MyJobsView: View { var body: some View { Text("Assigned / History") } }
struct WalletView: View { var body: some View { Text("Payouts & Statements") } }