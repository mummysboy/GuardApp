import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: SessionStore
    @State private var username = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage: String? = nil

    var body: some View {
        VStack(spacing: 16) {
            Text("GuardApp")
                .font(.largeTitle).bold()
            TextField("Username or Email", text: $username)
                .textContentType(.username)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textContentType(.password)
                .textFieldStyle(.roundedBorder)

            if let err = errorMessage {
                Text(err).foregroundColor(.red).font(.footnote)
            }

            Button {
                Task {
                    guard !isLoading else { return }
                    isLoading = true
                    await session.login(username: username, password: password)
                    isLoading = false
                }
            } label: {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Sign In").bold().frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(username.isEmpty || password.isEmpty)

            Spacer()
        }
        .padding()
    }
}