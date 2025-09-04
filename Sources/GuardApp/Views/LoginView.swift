import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: SessionStore
    @State private var username = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage: String? = nil
    @FocusState private var focusedField: Field?

    enum Field {
        case username
        case password
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                VStack(spacing: 16) {
                    Text("GuardApp")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 12) {
                        TextField("Username or Email", text: $username)
                            .textContentType(.username)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .textFieldStyle(.roundedBorder)
                            .focused($focusedField, equals: .username)
                            .submitLabel(.next)
                            .onSubmit {
                                focusedField = .password
                            }
                            .onChange(of: username) { _ in
                                errorMessage = nil
                            }
                        
                        SecureField("Password", text: $password)
                            .textContentType(.password)
                            .textFieldStyle(.roundedBorder)
                            .focused($focusedField, equals: .password)
                            .submitLabel(.done)
                            .onSubmit {
                                focusedField = nil
                                Task {
                                    await performLogin()
                                }
                            }
                            .onChange(of: password) { _ in
                                errorMessage = nil
                            }
                    }

                    if let err = errorMessage {
                        Text(err)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    Button {
                        Task {
                            await performLogin()
                        }
                    } label: {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(username.isEmpty || password.isEmpty || isLoading)
                    .frame(height: 44)
                }
                .padding(.horizontal, 32)
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func performLogin() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        await session.login(username: username, password: password)
        
        // Check if login was successful
        if case .unauthenticated = session.state {
            errorMessage = "Invalid username or password. Please try again."
        }
        
        isLoading = false
    }
}