import Foundation
import SwiftUI
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
        
        do {
            // Use Amplify DataStore to query users
            let users = try await Amplify.DataStore.query(User.self)
            
            await MainActor.run {
                self.users = users
                self.errorMessage = nil
            }
            print("Users loaded successfully via DataStore: \(users.count) users")
            
        } catch {
            print("DataStore query error: \(error.localizedDescription)")
            // Fallback to mock data if DataStore fails
            await MainActor.run {
                self.errorMessage = "Using offline mode - DataStore not available"
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
                // Create a new User with only the required fields for creation
                let newUser = User(
                    tenantId: user.tenantId,
                    role: user.role,
                    email: user.email,
                    firstName: user.firstName,
                    lastName: user.lastName,
                    phone: user.phone,
                    createdAt: Temporal.DateTime.now(),
                    updatedAt: Temporal.DateTime.now(),
                    _version: 1,
                    _lastChangedAt: Int(Date().timeIntervalSince1970)
                )
                
                // Use Amplify DataStore to save the user
                let savedUser = try await Amplify.DataStore.save(newUser)
                
                await MainActor.run {
                    self.users.append(savedUser)
                    self.errorMessage = nil
                }
                print("User added successfully via DataStore: \(savedUser.id)")
                
            } catch {
                await MainActor.run {
                    self.errorMessage = "Error adding user: \(error.localizedDescription)"
                }
                print("Error adding user: \(error)")
            }
            await MainActor.run { self.isLoading = false }
        }
    }

    func deleteUser(_ user: User) {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                // Use Amplify DataStore to delete the user
                try await Amplify.DataStore.delete(user)
                
                await MainActor.run {
                    // Remove from local array
                    if let index = self.users.firstIndex(where: { $0.id == user.id }) {
                        self.users.remove(at: index)
                    }
                    self.errorMessage = nil
                }
                print("User deleted successfully via DataStore: \(user.id)")
                
            } catch {
                await MainActor.run {
                    self.errorMessage = "Error deleting user: \(error.localizedDescription)"
                }
                print("Error deleting user: \(error)")
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
                updatedAt: Temporal.DateTime.now(),
                _version: 1,
                _lastChangedAt: Int(Date().timeIntervalSince1970)
            ),
            User(
                id: "2",
                tenantId: "tenant1",
                role: .securityGuard,
                email: "guard@example.com",
                firstName: "Jane",
                lastName: "Guard",
                phone: "+0987654321",
                createdAt: Temporal.DateTime.now(),
                updatedAt: Temporal.DateTime.now(),
                _version: 1,
                _lastChangedAt: Int(Date().timeIntervalSince1970)
            )
        ]
    }
    
    func updateUser(_ user: User) {
        Task {
            do {
                // Use Amplify DataStore to update the user
                let updatedUser = try await Amplify.DataStore.save(user)
                
                await MainActor.run {
                    // Update the user in local array
                    if let index = self.users.firstIndex(where: { $0.id == user.id }) {
                        self.users[index] = updatedUser
                    }
                    self.errorMessage = nil
                }
                print("User updated successfully via DataStore: \(updatedUser.id)")
                
            } catch {
                await MainActor.run {
                    self.errorMessage = "Error updating user: \(error.localizedDescription)"
                }
                print("Error updating user: \(error)")
            }
        }
    }
    
    func filteredUsers(by filter: UserFilter) -> [User] {
        switch filter {
        case .all:
            return users
        case .clients:
            return users.filter { $0.role == .supervisor }
        case .guards:
            return users.filter { $0.role == .securityGuard }
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
