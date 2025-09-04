import SwiftUI

import Amplify
import AWSAPIPlugin
import AWSCognitoAuthPlugin
import AWSDataStorePlugin

@main
struct GuardAppApp: App {
    @StateObject private var session = SessionStore()
    
    func setupAmplify() async {
        do {
            print("Setting up Amplify...")
            
            // Add plugins
            try Amplify.add(plugin: AWSAPIPlugin())
            print("✓ AWSAPIPlugin added")
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            print("✓ AWSCognitoAuthPlugin added")
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels()))
            print("✓ AWSDataStorePlugin added")
            
            // Use the default Amplify.configure() method which will automatically find amplifyconfiguration.json
            try Amplify.configure()
            print("✅ Amplify configured successfully!")
            
        } catch {
            print("❌ Failed to initialize Amplify: \(error)")
            print("Error details: \(error.localizedDescription)")
            // Continue with app initialization even if Amplify fails
            print("⚠️ App will run in offline mode")
        }
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(session)
                .task {
                    await setupAmplify()
                }
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