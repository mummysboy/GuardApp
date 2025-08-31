import SwiftUI

import Amplify
import AWSAPIPlugin
import AWSCognitoAuthPlugin
import AWSDataStorePlugin

@main
struct GuardAppApp: App {
    @StateObject private var session = SessionStore()
    
    init() {
        Task {
            await setupAmplify()
        }
    }

    func setupAmplify() async {
        do {
            try await Amplify.add(plugin: AWSAPIPlugin())
            try await Amplify.add(plugin: AWSCognitoAuthPlugin())
            try await Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels()))
            try await Amplify.configure()
            print("Amplify configured")
        } catch {
            print("Failed to initialize Amplify: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(session)
        }
    }
}

struct RootView: View {
    @EnvironmentObject var session: SessionStore

    var body: some View {
        Group {
            switch session.state {
            case .loading:
                ProgressView("Loading…")
                    .task { await session.bootstrap() }
            case .unauthenticated:
                LoginView()
            case .authenticated(let claims):
                DashboardView(claims: claims)
            }
        }
    }
}