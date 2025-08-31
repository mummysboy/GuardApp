import SwiftUI

struct BusinessTabView: View {
    let claims: UserClaims

    var body: some View {
        TabView {
            BusinessHomeView()
                .tabItem { Label("Home", systemImage: "briefcase") }
            ShiftsView()
                .tabItem { Label("Shifts", systemImage: "calendar") }
            MessagesView()
                .tabItem { Label("Messages", systemImage: "message") }
            BizSettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape") }
        }
    }
}

struct BusinessHomeView: View { var body: some View { Text("Business Home") } }
struct ShiftsView: View { var body: some View { Text("Shifts & Scheduling") } }
struct MessagesView: View { var body: some View { Text("Conversations") } }
struct BizSettingsView: View {
    @EnvironmentObject var session: SessionStore
    @State private var isLoading = false
    @State private var errorMessage: String? = nil

    var body: some View {
        VStack(spacing: 20) {
            Text("Business Settings").font(.title2)
            if let err = errorMessage {
                Text(err).foregroundColor(.red).font(.footnote)
            }
            Button {
                Task {
                    isLoading = true
                    do {
                        try await session.logout()
                    } catch {
                        errorMessage = "Logout failed. Please try again."
                    }
                    isLoading = false
                }
            } label: {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Logout").bold().frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            Spacer()
        }
        .padding()
    }
}
