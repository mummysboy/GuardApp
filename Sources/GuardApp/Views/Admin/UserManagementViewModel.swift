import Foundation
import Amplify
import Combine

@MainActor
class UserManagementViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Load mock data for testing
        loadMockData()
    }
    
    func loadUsers() async {
        isLoading = true
        errorMessage = nil
        
        // Check if Amplify is configured
        do {
            let result = try await Amplify.DataStore.query(User.self)
            users = result
        } catch {
            print("Amplify DataStore error: \(error.localizedDescription)")
            // Fallback to mock data if Amplify fails
            await MainActor.run {
                self.errorMessage = "Using offline mode - Amplify not available"
                self.loadMockData()
            }
        }
        isLoading = false
    }

    func addUser(_ user: User) {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                try await Amplify.DataStore.save(user)
                await loadUsers()
            } catch {
                await MainActor.run {
                    self.errorMessage = "Failed to add user: \(error.localizedDescription)"
                    // Fallback to local storage
                    var newUser = user
                    if newUser.id.isEmpty {
                        newUser = User(
                            id: UUID().uuidString,
                            tenantId: user.tenantId,
                            role: user.role,
                            email: user.email,
                            firstName: user.firstName,
                            lastName: user.lastName,
                            phone: user.phone,
                            createdAt: user.createdAt,
                            updatedAt: user.updatedAt
                        )
                    }
                    self.users.append(newUser)
                }
            }
            await MainActor.run { self.isLoading = false }
        }
    }

    func deleteUser(_ user: User) {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                try await Amplify.DataStore.delete(user)
                await loadUsers()
            } catch {
                await MainActor.run {
                    self.errorMessage = "Failed to delete user: \(error.localizedDescription)"
                    // Remove from local array as fallback
                    if let index = self.users.firstIndex(where: { $0.id == user.id }) {
                        self.users.remove(at: index)
                    }
                }
            }
            await MainActor.run { self.isLoading = false }
        }
    }
    
    private func loadMockData() {
        users = [
            User(
                id: "1",
                tenantId: "tenant1",
                role: .admin,
                email: "admin@example.com",
                firstName: "John",
                lastName: "Admin",
                phone: "+1234567890",
                createdAt: Temporal.DateTime.now(),
                updatedAt: Temporal.DateTime.now()
            ),
            User(
                id: "2",
                tenantId: "tenant1",
                role: .worker,
                email: "worker@example.com",
                firstName: "Jane",
                lastName: "Worker",
                phone: "+0987654321",
                createdAt: Temporal.DateTime.now(),
                updatedAt: Temporal.DateTime.now()
            )
        ]
    }
    
    func updateUser(_ user: User) {
        Task {
            do {
                // Try to update in Amplify DataStore
                let updatedUser = try await Amplify.DataStore.save(user)
                if let index = users.firstIndex(where: { $0.id == user.id }) {
                    users[index] = updatedUser
                }
            } catch {
                // If Amplify fails, update local array
                print("Amplify DataStore not available, updating local storage: \(error.localizedDescription)")
                if let index = users.firstIndex(where: { $0.id == user.id }) {
                    users[index] = user
                }
            }
        }
    }
    
    func filteredUsers(by filter: UserFilter) -> [User] {
        switch filter {
        case .all:
            return users
        case .clients:
            return users.filter { $0.role == .businessOwner || $0.role == .businessStaff }
        case .guards:
            return users.filter { $0.role == .worker }
        case .admins:
            return users.filter { $0.role == .admin }
        }
    }
    
    func searchUsers(query: String) -> [User] {
        guard !query.isEmpty else { return users }
        
        return users.filter { user in
            let fullName = "\(user.firstName ?? "") \(user.lastName ?? "")".lowercased()
            let email = user.email.lowercased()
            let searchQuery = query.lowercased()
            
            return fullName.contains(searchQuery) || 
                   email.contains(searchQuery) ||
                   user.role.rawValue.lowercased().contains(searchQuery)
        }
    }
}
