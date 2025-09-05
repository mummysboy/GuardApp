import SwiftUI
import Amplify

// MARK: - Enums
enum UserFilter: String, CaseIterable {
    case all = "All Users"
    case clients = "Clients"
    case guards = "Guards"
    case admins = "Admins"
}

struct AdminTabView: View {
    let claims: UserClaims

    var body: some View {
        TabView {
            AdminHomeView()
                .tabItem { 
                    Label("Command", systemImage: "shield.fill") 
                }
            UserManagementView()
                .tabItem { 
                    Label("Personnel", systemImage: "person.3.fill") 
                }
            TenantsView()
                .tabItem { 
                    Label("Territories", systemImage: "building.2.fill") 
                }
            ReportsView()
                .tabItem { 
                    Label("Intelligence", systemImage: "chart.bar.fill") 
                }
            AuditsView()
                .tabItem { 
                    Label("Surveillance", systemImage: "eye.fill") 
                }
            SettingsView()
                .tabItem { 
                    Label("Control", systemImage: "gearshape.fill") 
                }
        }
        .accentColor(.red)
        .preferredColorScheme(.dark)
    }
}

struct AdminHomeView: View {
    @StateObject private var viewModel = AdminHomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Dark background with subtle pattern
                Color.black
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 32) {
                        // Command Center Header
                        VStack(spacing: 12) {
                            HStack {
                                Image(systemName: "shield.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.red)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("COMMAND")
                                        .font(.title2)
                                        .fontWeight(.black)
                                        .foregroundColor(.white)
                                    
                                    Text("SECURITY OPS")
                                        .font(.caption2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.red)
                                        .tracking(1)
                                }
                                
                                Spacer()
                                
                                // Status indicator
                                HStack(spacing: 4) {
                                    Circle()
                                        .fill(.green)
                                        .frame(width: 8, height: 8)
                                    Text("ONLINE")
                                        .font(.caption2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.green)
                                }
                            }
                            
                            Text("ALL SYSTEMS SECURE")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(
                                    LinearGradient(
                                        colors: [Color.black, Color.gray.opacity(0.3)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.red.opacity(0.5), lineWidth: 2)
                                )
                        )
                        
                        // Threat Level Cards
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 12) {
                            ThreatLevelCard(
                                title: "PERSONNEL",
                                value: "\(viewModel.totalUsers)",
                                icon: "person.3.fill",
                                threatLevel: .low,
                                subtitle: "ACTIVE"
                            )
                            
                            ThreatLevelCard(
                                title: "MISSIONS",
                                value: "\(viewModel.activeShifts)",
                                icon: "clock.fill",
                                threatLevel: .medium,
                                subtitle: "ACTIVE"
                            )
                            
                            ThreatLevelCard(
                                title: "TERRITORIES",
                                value: "\(viewModel.totalTenants)",
                                icon: "building.2.fill",
                                threatLevel: .low,
                                subtitle: "SECTORS"
                            )
                            
                            ThreatLevelCard(
                                title: "ALERTS",
                                value: "\(viewModel.pendingRequests)",
                                icon: "exclamationmark.triangle.fill",
                                threatLevel: .high,
                                subtitle: "PENDING"
                            )
                        }
                        
                        // Tactical Operations
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "bolt.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 16))
                                Text("TACTICAL OPS")
                                    .font(.subheadline)
                                    .fontWeight(.black)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 12) {
                                TacticalActionCard(
                                    title: "DEPLOY",
                                    subtitle: "New operative",
                                    icon: "person.badge.plus",
                                    color: .red
                                ) {
                                    // Action
                                }
                                
                                TacticalActionCard(
                                    title: "INTEL",
                                    subtitle: "Reports",
                                    icon: "chart.bar.fill",
                                    color: .blue
                                ) {
                                    // Action
                                }
                                
                                TacticalActionCard(
                                    title: "CONTROL",
                                    subtitle: "Settings",
                                    icon: "gearshape.fill",
                                    color: .gray
                                ) {
                                    // Action
                                }
                                
                                TacticalActionCard(
                                    title: "SURVEIL",
                                    subtitle: "Monitor",
                                    icon: "eye.fill",
                                    color: .purple
                                ) {
                                    // Action
                                }
                            }
                        }
                        
                        // Mission Briefings
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "doc.text.fill")
                                    .foregroundColor(.orange)
                                    .font(.system(size: 16))
                                Text("MISSION BRIEFS")
                                    .font(.subheadline)
                                    .fontWeight(.black)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            
                            VStack(spacing: 12) {
                                ForEach(viewModel.recentActivities.prefix(5), id: \.id) { activity in
                                    MissionBriefingRow(activity: activity)
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .refreshable {
                await viewModel.loadDashboardData()
            }
            .task {
                await viewModel.loadDashboardData()
            }
        }
    }
}

// MARK: - Supporting Views

enum ThreatLevel {
    case low, medium, high, critical
    
    var color: Color {
        switch self {
        case .low: return .green
        case .medium: return .yellow
        case .high: return .orange
        case .critical: return .red
        }
    }
    
    var borderColor: Color {
        switch self {
        case .low: return .green.opacity(0.5)
        case .medium: return .yellow.opacity(0.5)
        case .high: return .orange.opacity(0.5)
        case .critical: return .red.opacity(0.8)
        }
    }
}

struct ThreatLevelCard: View {
    let title: String
    let value: String
    let icon: String
    let threatLevel: ThreatLevel
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(threatLevel.color)
                
                Spacer()
                
                // Threat level indicator
                Circle()
                    .fill(threatLevel.color)
                    .frame(width: 8, height: 8)
                    .overlay(
                        Circle()
                            .stroke(threatLevel.color, lineWidth: 1)
                            .scaleEffect(1.3)
                            .opacity(0.3)
                    )
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.system(size: 24, weight: .black, design: .monospaced))
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(threatLevel.color)
                    .tracking(0.5)
                
                Text(subtitle)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.6))
                    .tracking(0.3)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        colors: [Color.black, Color.gray.opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(threatLevel.borderColor, lineWidth: 1)
                )
        )
    }
}

struct TacticalActionCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: icon)
                        .font(.title3)
                        .foregroundColor(color)
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.6))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .tracking(0.3)
                    
                    Text(subtitle)
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.7))
                        .tracking(0.2)
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(
                            colors: [Color.black, Color.gray.opacity(0.3)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(color.opacity(0.3), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct MissionBriefingRow: View {
    let activity: ActivityItem
    
    var body: some View {
        HStack(spacing: 12) {
            // Status indicator
            RoundedRectangle(cornerRadius: 3)
                .fill(activity.color)
                .frame(width: 3, height: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image(systemName: activity.icon)
                        .font(.caption2)
                        .foregroundColor(activity.color)
                    
                    Text(activity.title)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text(activity.timeAgo)
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.6))
                        .tracking(0.3)
                }
                
                Text(activity.description)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(2)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
    }
}

// MARK: - Data Models

struct ActivityItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
    let color: Color
    let timeAgo: String
}

// MARK: - View Model

@MainActor
class AdminHomeViewModel: ObservableObject {
    @Published var totalUsers = 0
    @Published var activeShifts = 0
    @Published var totalTenants = 0
    @Published var pendingRequests = 0
    @Published var recentActivities: [ActivityItem] = []
    
    func loadDashboardData() async {
        // Load users count
        do {
            let users = try await Amplify.DataStore.query(User.self)
            totalUsers = users.count
        } catch {
            print("Failed to load users: \(error)")
        }
        
        // Load shifts count
        do {
            let shifts = try await Amplify.DataStore.query(Shift.self)
            activeShifts = shifts.filter { $0.state == .pending || $0.state == .assigned }.count
        } catch {
            print("Failed to load shifts: \(error)")
        }
        
        // Calculate unique tenants
        do {
            let users = try await Amplify.DataStore.query(User.self)
            let tenantIds = Set(users.map { $0.tenantId })
            totalTenants = tenantIds.count
        } catch {
            print("Failed to calculate tenants: \(error)")
        }
        
        // Mock pending requests (in real app, this would be actual pending requests)
        pendingRequests = Int.random(in: 0...5)
        
        // Load recent activities
        loadRecentActivities()
    }
    
    private func loadRecentActivities() {
        recentActivities = [
            ActivityItem(
                title: "DEPLOYED",
                description: "Agent Jane Doe to Sector Alpha",
                icon: "person.badge.plus",
                color: .green,
                timeAgo: "2M"
            ),
            ActivityItem(
                title: "COMPLETED",
                description: "Downtown Mall - SECURE",
                icon: "checkmark.shield",
                color: .blue,
                timeAgo: "15M"
            ),
            ActivityItem(
                title: "PAYMENT",
                description: "Credits to Op #1234",
                icon: "creditcard.fill",
                color: .green,
                timeAgo: "1H"
            ),
            ActivityItem(
                title: "MAINTENANCE",
                description: "Database backup complete",
                icon: "gearshape.fill",
                color: .orange,
                timeAgo: "2H"
            ),
            ActivityItem(
                title: "EXPANSION",
                description: "New surveillance zone",
                icon: "building.2.fill",
                color: .purple,
                timeAgo: "3H"
            )
        ]
    }
}

struct UserManagementView: View {
    @StateObject private var viewModel = UserManagementViewModel()
    @State private var showingAddUser = false
    @State private var selectedFilter: UserFilter = .all
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Tactical Header
                    VStack(spacing: 12) {
                        HStack {
                            Image(systemName: "person.3.fill")
                                .font(.title3)
                                .foregroundColor(.red)
                            
                            Text("PERSONNEL")
                                .font(.title3)
                                .fontWeight(.black)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button(action: { showingAddUser = true }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title3)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .font(.caption)
                            
                            TextField("Search operatives...", text: $searchText)
                                .textFieldStyle(PlainTextFieldStyle())
                                .foregroundColor(.white)
                                .font(.caption)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.2))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                )
                        )
                        
                        // Filter Picker
                        Picker("Filter", selection: $selectedFilter) {
                            ForEach(UserFilter.allCases, id: \.self) { filter in
                                Text(filter.rawValue).tag(filter)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .background(Color.gray.opacity(0.2))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    
                    // Personnel List
                    if viewModel.isLoading {
                        Spacer()
                        VStack(spacing: 16) {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .red))
                            Text("LOADING PERSONNEL DATA...")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white.opacity(0.7))
                                .tracking(1)
                        }
                        Spacer()
                    } else {
                        List {
                            ForEach(filteredAndSearchedUsers, id: \.id) { user in
                                OperativeRowView(user: user) {
                                    viewModel.deleteUser(user)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                        .background(Color.clear)
                        .refreshable {
                            await viewModel.loadUsers()
                        }
                        .overlay(
                            Group {
                                if filteredAndSearchedUsers.isEmpty {
                                    VStack(spacing: 20) {
                                        Image(systemName: "person.3.slash")
                                            .font(.system(size: 64))
                                            .foregroundColor(.gray.opacity(0.5))
                                        Text("NO OPERATIVES FOUND")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white.opacity(0.7))
                                            .tracking(1)
                                        Text("Adjust search parameters or deploy new personnel")
                                            .font(.subheadline)
                                            .foregroundColor(.white.opacity(0.5))
                                            .multilineTextAlignment(.center)
                                    }
                                    .padding()
                                }
                            }
                        )
                    }
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $showingAddUser) {
                AddUserView { user in
                    viewModel.addUser(user)
                    showingAddUser = false
                }
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("ACKNOWLEDGED") {
                    viewModel.errorMessage = nil
                }
            } message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            }
            .task {
                await viewModel.loadUsers()
            }
        }
    }
    
    private var filteredAndSearchedUsers: [User] {
        let filtered = viewModel.filteredUsers(by: selectedFilter)
        if searchText.isEmpty {
            return filtered
        } else {
            return viewModel.searchUsers(query: searchText).filter { user in
                filtered.contains { $0.id == user.id }
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct OperativeRowView: View {
    let user: User
    let onDelete: () -> Void
    @State private var showingDeleteAlert = false
    @State private var showingEditSheet = false
    
    var body: some View {
        HStack(spacing: 12) {
            // Operative Badge
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(roleColor.opacity(0.2))
                    .frame(width: 48, height: 48)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(roleColor, lineWidth: 1)
                    )
                
                VStack(spacing: 1) {
                    Text(userInitials)
                        .font(.caption)
                        .fontWeight(.black)
                        .foregroundColor(roleColor)
                    
                    Text(roleAbbreviation)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(roleColor)
                        .tracking(0.5)
                }
            }
            
            // Operative Info
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(userDisplayName)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    // Status indicator
                    Circle()
                        .fill(.green)
                        .frame(width: 6, height: 6)
                }
                
                Text(user.email)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                    .lineLimit(1)
                
                HStack {
                    Text("SECTOR: \(user.tenantId)")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white.opacity(0.6))
                        .tracking(0.3)
                    
                    Spacer()
                    
                    Text(roleTitle)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(roleColor)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(roleColor.opacity(0.2))
                        .cornerRadius(4)
                }
            }
            
            // Action Buttons
            HStack(spacing: 8) {
                Button(action: { showingEditSheet = true }) {
                    Image(systemName: "pencil.circle.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                
                Button(action: { showingDeleteAlert = true }) {
                    Image(systemName: "trash.circle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        )
        .alert("TERMINATE OPERATIVE", isPresented: $showingDeleteAlert) {
            Button("CANCEL", role: .cancel) { }
            Button("TERMINATE", role: .destructive) {
                onDelete()
            }
        } message: {
            Text("Are you sure you want to terminate \(userDisplayName)? This action cannot be undone.")
        }
        .sheet(isPresented: $showingEditSheet) {
            EditUserView(user: user)
        }
    }
    
    private var userDisplayName: String {
        let firstName = user.firstName ?? ""
        let lastName = user.lastName ?? ""
        if firstName.isEmpty && lastName.isEmpty {
            return user.email
        }
        return "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
    }
    
    private var userInitials: String {
        let firstName = user.firstName ?? ""
        let lastName = user.lastName ?? ""
        
        if !firstName.isEmpty && !lastName.isEmpty {
            return "\(firstName.prefix(1))\(lastName.prefix(1))".uppercased()
        } else if !firstName.isEmpty {
            return String(firstName.prefix(2)).uppercased()
        } else if !lastName.isEmpty {
            return String(lastName.prefix(2)).uppercased()
        } else {
            return String(user.email.prefix(2)).uppercased()
        }
    }
    
    private var roleAbbreviation: String {
        switch user.role {
        case .admin: return "CMD"
        case .supervisor: return "SUP"
        case .securityGuard: return "OP"
        }
    }
    
    private var roleTitle: String {
        switch user.role {
        case .admin: return "COMMANDER"
        case .supervisor: return "SUPERVISOR"
        case .securityGuard: return "OPERATIVE"
        }
    }
    
    private var roleColor: Color {
        switch user.role {
        case .admin: return .red
        case .supervisor: return .blue
        case .securityGuard: return .orange
        }
    }
}

struct EditUserView: View {
    let user: User
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = UserManagementViewModel()
    
    @State private var firstName: String
    @State private var lastName: String
    @State private var email: String
    @State private var phone: String
    @State private var selectedRole: Role
    @State private var tenantId: String
    @State private var showingValidationAlert = false
    @State private var validationMessage = ""
    
    init(user: User) {
        self.user = user
        _firstName = State(initialValue: user.firstName ?? "")
        _lastName = State(initialValue: user.lastName ?? "")
        _email = State(initialValue: user.email)
        _phone = State(initialValue: user.phone ?? "")
        _selectedRole = State(initialValue: user.role)
        _tenantId = State(initialValue: user.tenantId)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Personal Information") {
                    TextField("First Name", text: $firstName)
                        .textContentType(.givenName)
                    TextField("Last Name", text: $lastName)
                        .textContentType(.familyName)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)
                    TextField("Phone", text: $phone)
                        .keyboardType(.phonePad)
                        .textContentType(.telephoneNumber)
                }
                
                Section("Role & Organization") {
                    Picker("Role", selection: $selectedRole) {
                        Text("Guard").tag(Role.securityGuard)
                        Text("Supervisor").tag(Role.supervisor)
                        Text("Admin").tag(Role.admin)
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    TextField("Tenant ID", text: $tenantId)
                        .autocapitalization(.none)
                }
            }
            .navigationTitle("Edit User")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if validateForm() {
                            let updatedUser = User(
                                id: user.id,
                                tenantId: tenantId,
                                role: selectedRole,
                                email: email,
                                firstName: firstName.isEmpty ? nil : firstName,
                                lastName: lastName.isEmpty ? nil : lastName,
                                phone: phone.isEmpty ? nil : phone,
                                createdAt: user.createdAt,
                                updatedAt: Temporal.DateTime.now(),
                                _version: user._version,
                                _lastChangedAt: Int(Date().timeIntervalSince1970)
                            )
                            viewModel.updateUser(updatedUser)
                            dismiss()
                        } else {
                            showingValidationAlert = true
                        }
                    }
                    .disabled(!isFormValid)
                }
            }
            .alert("Validation Error", isPresented: $showingValidationAlert) {
                Button("OK") { }
            } message: {
                Text(validationMessage)
            }
        }
    }
    
    private var isFormValid: Bool {
        !email.isEmpty && !tenantId.isEmpty && isValidEmail(email)
    }
    
    private func validateForm() -> Bool {
        if email.isEmpty {
            validationMessage = "Email is required"
            return false
        }
        
        if !isValidEmail(email) {
            validationMessage = "Please enter a valid email address"
            return false
        }
        
        if tenantId.isEmpty {
            validationMessage = "Tenant ID is required"
            return false
        }
        
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

struct AddUserView: View {
    let onSave: (User) -> Void
    @Environment(\.dismiss) private var dismiss
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var selectedRole: Role = .securityGuard
    @State private var tenantId = ""
    @State private var showingValidationAlert = false
    @State private var validationMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Personal Information") {
                    TextField("First Name", text: $firstName)
                        .textContentType(.givenName)
                    TextField("Last Name", text: $lastName)
                        .textContentType(.familyName)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)
                    TextField("Phone", text: $phone)
                        .keyboardType(.phonePad)
                        .textContentType(.telephoneNumber)
                }
                
                Section("Role & Organization") {
                    Picker("Role", selection: $selectedRole) {
                        Text("Guard").tag(Role.securityGuard)
                        Text("Supervisor").tag(Role.supervisor)
                        Text("Admin").tag(Role.admin)
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    TextField("Tenant ID", text: $tenantId)
                        .autocapitalization(.none)
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Role Descriptions:")
                            .font(.headline)
                        
                        Text("• Guard: Security personnel who can be assigned to shifts")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("• Supervisor: Managers who can oversee guards and shifts")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("• Admin: System administrators with full access")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Add User")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if validateForm() {
                            let newUser = User(
                                tenantId: tenantId,
                                role: selectedRole,
                                email: email,
                                firstName: firstName.isEmpty ? nil : firstName,
                                lastName: lastName.isEmpty ? nil : lastName,
                                phone: phone.isEmpty ? nil : phone,
                                createdAt: Temporal.DateTime.now(),
                                updatedAt: Temporal.DateTime.now(),
                                _version: 1,
                                _lastChangedAt: Int(Date().timeIntervalSince1970)
                            )
                            onSave(newUser)
                        } else {
                            showingValidationAlert = true
                        }
                    }
                    .disabled(!isFormValid)
                }
            }
            .alert("Validation Error", isPresented: $showingValidationAlert) {
                Button("OK") { }
            } message: {
                Text(validationMessage)
            }
        }
    }
    
    private var isFormValid: Bool {
        !email.isEmpty && !tenantId.isEmpty && isValidEmail(email)
    }
    
    private func validateForm() -> Bool {
        if email.isEmpty {
            validationMessage = "Email is required"
            return false
        }
        
        if !isValidEmail(email) {
            validationMessage = "Please enter a valid email address"
            return false
        }
        
        if tenantId.isEmpty {
            validationMessage = "Tenant ID is required"
            return false
        }
        
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

struct TenantsView: View {
    @StateObject private var viewModel = TenantsViewModel()
    @State private var showingAddTenant = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                SearchBar(text: $searchText, placeholder: "Search tenants...")
                    .padding(.horizontal)
                    .padding(.top)
                
                // Tenant List
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading tenants...")
                    Spacer()
                } else {
                    List {
                        ForEach(filteredTenants, id: \.id) { tenant in
                            TenantRowView(tenant: tenant) {
                                viewModel.deleteTenant(tenant)
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.loadTenants()
                    }
                    .overlay(
                        Group {
                            if filteredTenants.isEmpty {
                                VStack(spacing: 16) {
                                    Image(systemName: "building.2.slash")
                                        .font(.system(size: 48))
                                        .foregroundColor(.secondary)
                                    Text("No tenants found")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                    Text("Try adjusting your search or add a new tenant")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                            }
                        }
                    )
                }
            }
            .navigationTitle("Tenants")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTenant = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTenant) {
                AddTenantView { tenant in
                    viewModel.addTenant(tenant)
                    showingAddTenant = false
                }
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") {
                    viewModel.errorMessage = nil
                }
            } message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            }
            .task {
                await viewModel.loadTenants()
            }
        }
    }
    
    private var filteredTenants: [TenantInfo] {
        if searchText.isEmpty {
            return viewModel.tenants
        } else {
            return viewModel.tenants.filter { tenant in
                tenant.name.lowercased().contains(searchText.lowercased()) ||
                tenant.id.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

struct TenantRowView: View {
    let tenant: TenantInfo
    let onDelete: () -> Void
    @State private var showingDeleteAlert = false
    @State private var showingEditSheet = false
    
    var body: some View {
        HStack(spacing: 12) {
            // Tenant Avatar
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 50, height: 50)
                .overlay(
                    Text(tenantInitials)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                )
            
            // Tenant Info
            VStack(alignment: .leading, spacing: 4) {
                Text(tenant.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text("ID: \(tenant.id)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                HStack {
                    Text("\(tenant.userCount) users")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("\(tenant.shiftCount) shifts")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // Action Buttons
            HStack(spacing: 8) {
                Button(action: { showingEditSheet = true }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.blue)
                }
                Button(action: { showingDeleteAlert = true }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.vertical, 4)
        .alert("Delete Tenant", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                onDelete()
            }
        } message: {
            Text("Are you sure you want to delete \(tenant.name)? This will also delete all associated users and shifts.")
        }
        .sheet(isPresented: $showingEditSheet) {
            EditTenantView(tenant: tenant)
        }
    }
    
    private var tenantInitials: String {
        let words = tenant.name.components(separatedBy: " ")
        if words.count >= 2 {
            return "\(words[0].prefix(1))\(words[1].prefix(1))".uppercased()
        } else {
            return String(tenant.name.prefix(2)).uppercased()
        }
    }
}

struct AddTenantView: View {
    let onSave: (TenantInfo) -> Void
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var description = ""
    @State private var showingValidationAlert = false
    @State private var validationMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Tenant Information") {
                    TextField("Tenant Name", text: $name)
                    TextField("Description (Optional)", text: $description)
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tenant Information:")
                            .font(.headline)
                        
                        Text("• A tenant represents a client organization")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("• Each tenant has their own users and shifts")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("• Tenant ID will be auto-generated")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Add Tenant")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if validateForm() {
                            let newTenant = TenantInfo(
                                id: UUID().uuidString,
                                name: name,
                                description: description.isEmpty ? nil : description,
                                userCount: 0,
                                shiftCount: 0,
                                createdAt: Date()
                            )
                            onSave(newTenant)
                        } else {
                            showingValidationAlert = true
                        }
                    }
                    .disabled(!isFormValid)
                }
            }
            .alert("Validation Error", isPresented: $showingValidationAlert) {
                Button("OK") { }
            } message: {
                Text(validationMessage)
            }
        }
    }
    
    private var isFormValid: Bool {
        !name.isEmpty
    }
    
    private func validateForm() -> Bool {
        if name.isEmpty {
            validationMessage = "Tenant name is required"
            return false
        }
        return true
    }
}

struct EditTenantView: View {
    let tenant: TenantInfo
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String
    @State private var description: String
    @State private var showingValidationAlert = false
    @State private var validationMessage = ""
    
    init(tenant: TenantInfo) {
        self.tenant = tenant
        _name = State(initialValue: tenant.name)
        _description = State(initialValue: tenant.description ?? "")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Tenant Information") {
                    TextField("Tenant Name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Edit Tenant")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if validateForm() {
                            // Update logic would go here
                            dismiss()
                        } else {
                            showingValidationAlert = true
                        }
                    }
                    .disabled(!isFormValid)
                }
            }
            .alert("Validation Error", isPresented: $showingValidationAlert) {
                Button("OK") { }
            } message: {
                Text(validationMessage)
            }
        }
    }
    
    private var isFormValid: Bool {
        !name.isEmpty
    }
    
    private func validateForm() -> Bool {
        if name.isEmpty {
            validationMessage = "Tenant name is required"
            return false
        }
        return true
    }
}

// MARK: - Tenant Data Model

struct TenantInfo: Identifiable {
    let id: String
    let name: String
    let description: String?
    let userCount: Int
    let shiftCount: Int
    let createdAt: Date
}

// MARK: - Tenants View Model

@MainActor
class TenantsViewModel: ObservableObject {
    @Published var tenants: [TenantInfo] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadTenants() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Get all users to group by tenant
            let users = try await Amplify.DataStore.query(User.self)
            let shifts = try await Amplify.DataStore.query(Shift.self)
            
            // Group users by tenant
            let userGroups = Dictionary(grouping: users) { $0.tenantId }
            let shiftGroups = Dictionary(grouping: shifts) { $0.tenantId }
            
            // Create tenant info
            let allTenantIds = Set(userGroups.keys).union(shiftGroups.keys)
            
            tenants = allTenantIds.map { tenantId in
                let userCount = userGroups[tenantId]?.count ?? 0
                let shiftCount = shiftGroups[tenantId]?.count ?? 0
                
                return TenantInfo(
                    id: tenantId,
                    name: "Tenant \(tenantId.prefix(8))", // Generate a readable name
                    description: "Organization with ID: \(tenantId)",
                    userCount: userCount,
                    shiftCount: shiftCount,
                    createdAt: Date() // In real app, this would come from the database
                )
            }
            
            // Sort by name
            tenants.sort { $0.name < $1.name }
            
        } catch {
            errorMessage = "Failed to load tenants: \(error.localizedDescription)"
            print("Failed to load tenants: \(error)")
        }
        
        isLoading = false
    }
    
    func addTenant(_ tenant: TenantInfo) {
        tenants.append(tenant)
        tenants.sort { $0.name < $1.name }
    }
    
    func deleteTenant(_ tenant: TenantInfo) {
        if let index = tenants.firstIndex(where: { $0.id == tenant.id }) {
            tenants.remove(at: index)
        }
    }
}

struct ReportsView: View {
    @StateObject private var viewModel = ReportsViewModel()
    @State private var selectedReportType: ReportType = .userActivity
    @State private var selectedTimeRange: TimeRange = .last7Days
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Report Type Selector
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Report Type")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Picker("Report Type", selection: $selectedReportType) {
                            ForEach(ReportType.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    // Time Range Selector
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Time Range")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Picker("Time Range", selection: $selectedTimeRange) {
                            ForEach(TimeRange.allCases, id: \.self) { range in
                                Text(range.rawValue).tag(range)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    // Report Content
                    switch selectedReportType {
                    case .userActivity:
                        UserActivityReportView(data: viewModel.userActivityData)
                    case .shiftPerformance:
                        ShiftPerformanceReportView(data: viewModel.shiftPerformanceData)
                    case .financialSummary:
                        FinancialSummaryReportView(data: viewModel.financialData)
                    case .systemHealth:
                        SystemHealthReportView(data: viewModel.systemHealthData)
                    }
                }
                .padding()
            }
            .navigationTitle("Reports")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Export") {
                        viewModel.exportReport(type: selectedReportType, timeRange: selectedTimeRange)
                    }
                }
            }
            .refreshable {
                await viewModel.loadReportData(type: selectedReportType, timeRange: selectedTimeRange)
            }
            .task {
                await viewModel.loadReportData(type: selectedReportType, timeRange: selectedTimeRange)
            }
        }
    }
}

// MARK: - Report Views

struct UserActivityReportView: View {
    let data: UserActivityData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("User Activity Report")
                .font(.title2)
                .fontWeight(.bold)
            
            // Summary Cards
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ReportCard(title: "Active Users", value: "\(data.activeUsers)", color: .green)
                ReportCard(title: "New Users", value: "\(data.newUsers)", color: .blue)
                ReportCard(title: "Login Sessions", value: "\(data.loginSessions)", color: .orange)
                ReportCard(title: "Failed Logins", value: "\(data.failedLogins)", color: .red)
            }
            
            // Activity Chart
            VStack(alignment: .leading, spacing: 8) {
                Text("Daily Activity")
                    .font(.headline)
                
                ChartView(data: data.dailyActivity, title: "User Logins")
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        }
    }
}

struct ShiftPerformanceReportView: View {
    let data: ShiftPerformanceData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Shift Performance Report")
                .font(.title2)
                .fontWeight(.bold)
            
            // Summary Cards
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ReportCard(title: "Total Shifts", value: "\(data.totalShifts)", color: .blue)
                ReportCard(title: "Completed", value: "\(data.completedShifts)", color: .green)
                ReportCard(title: "On Time", value: "\(data.onTimeShifts)", color: .green)
                ReportCard(title: "Late", value: "\(data.lateShifts)", color: .orange)
            }
            
            // Performance Metrics
            VStack(alignment: .leading, spacing: 8) {
                Text("Performance Metrics")
                    .font(.headline)
                
                HStack {
                    Text("Completion Rate")
                    Spacer()
                    Text("\(Int(data.completionRate * 100))%")
                        .fontWeight(.semibold)
                }
                
                HStack {
                    Text("On-Time Rate")
                    Spacer()
                    Text("\(Int(data.onTimeRate * 100))%")
                        .fontWeight(.semibold)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        }
    }
}

struct FinancialSummaryReportView: View {
    let data: FinancialData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Financial Summary Report")
                .font(.title2)
                .fontWeight(.bold)
            
            // Summary Cards
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ReportCard(title: "Total Revenue", value: "$\(data.totalRevenue)", color: .green)
                ReportCard(title: "Total Expenses", value: "$\(data.totalExpenses)", color: .red)
                ReportCard(title: "Net Profit", value: "$\(data.netProfit)", color: (Double(data.netProfit) ?? 0) >= 0 ? .green : .red)
                ReportCard(title: "Pending Payments", value: "$\(data.pendingPayments)", color: .orange)
            }
            
            // Revenue Chart
            VStack(alignment: .leading, spacing: 8) {
                Text("Revenue Trend")
                    .font(.headline)
                
                ChartView(data: data.revenueTrend, title: "Monthly Revenue")
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        }
    }
}

struct SystemHealthReportView: View {
    let data: SystemHealthData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("System Health Report")
                .font(.title2)
                .fontWeight(.bold)
            
            // Summary Cards
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ReportCard(title: "Uptime", value: "\(Int(data.uptime * 100))%", color: .green)
                ReportCard(title: "Response Time", value: "\(data.avgResponseTime)ms", color: .blue)
                ReportCard(title: "Error Rate", value: "\(Int(data.errorRate * 100))%", color: .red)
                ReportCard(title: "Active Sessions", value: "\(data.activeSessions)", color: .orange)
            }
            
            // System Status
            VStack(alignment: .leading, spacing: 8) {
                Text("System Status")
                    .font(.headline)
                
                HStack {
                    Circle()
                        .fill(data.systemStatus == .healthy ? Color.green : Color.red)
                        .frame(width: 12, height: 12)
                    Text(data.systemStatus.rawValue)
                        .fontWeight(.semibold)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        }
    }
}

// MARK: - Supporting Views

struct ReportCard: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

struct ChartView: View {
    let data: [ChartDataPoint]
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // Simple bar chart representation
            HStack(alignment: .bottom, spacing: 4) {
                ForEach(data, id: \.label) { point in
                    VStack {
                        Rectangle()
                            .fill(Color.blue.opacity(0.7))
                            .frame(width: 20, height: CGFloat(point.value) * 2)
                        
                        Text(point.label)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(height: 100)
        }
    }
}

// MARK: - Report Data Models

enum ReportType: String, CaseIterable {
    case userActivity = "User Activity"
    case shiftPerformance = "Shift Performance"
    case financialSummary = "Financial Summary"
    case systemHealth = "System Health"
}

enum TimeRange: String, CaseIterable {
    case last7Days = "7 Days"
    case last30Days = "30 Days"
    case last90Days = "90 Days"
    case lastYear = "1 Year"
}

enum SystemStatus: String {
    case healthy = "Healthy"
    case degraded = "Degraded"
    case critical = "Critical"
}

struct ChartDataPoint {
    let label: String
    let value: Double
}

struct UserActivityData {
    let activeUsers: Int
    let newUsers: Int
    let loginSessions: Int
    let failedLogins: Int
    let dailyActivity: [ChartDataPoint]
}

struct ShiftPerformanceData {
    let totalShifts: Int
    let completedShifts: Int
    let onTimeShifts: Int
    let lateShifts: Int
    let completionRate: Double
    let onTimeRate: Double
}

struct FinancialData {
    let totalRevenue: String
    let totalExpenses: String
    let netProfit: String
    let pendingPayments: String
    let revenueTrend: [ChartDataPoint]
}

struct SystemHealthData {
    let uptime: Double
    let avgResponseTime: Int
    let errorRate: Double
    let activeSessions: Int
    let systemStatus: SystemStatus
}

// MARK: - Reports View Model

@MainActor
class ReportsViewModel: ObservableObject {
    @Published var userActivityData = UserActivityData(activeUsers: 0, newUsers: 0, loginSessions: 0, failedLogins: 0, dailyActivity: [])
    @Published var shiftPerformanceData = ShiftPerformanceData(totalShifts: 0, completedShifts: 0, onTimeShifts: 0, lateShifts: 0, completionRate: 0, onTimeRate: 0)
    @Published var financialData = FinancialData(totalRevenue: "0", totalExpenses: "0", netProfit: "0", pendingPayments: "0", revenueTrend: [])
    @Published var systemHealthData = SystemHealthData(uptime: 0, avgResponseTime: 0, errorRate: 0, activeSessions: 0, systemStatus: .healthy)
    
    func loadReportData(type: ReportType, timeRange: TimeRange) async {
        // In a real app, this would load data from the database
        // For now, we'll generate mock data
        
        switch type {
        case .userActivity:
            userActivityData = generateUserActivityData(timeRange: timeRange)
        case .shiftPerformance:
            shiftPerformanceData = generateShiftPerformanceData(timeRange: timeRange)
        case .financialSummary:
            financialData = generateFinancialData(timeRange: timeRange)
        case .systemHealth:
            systemHealthData = generateSystemHealthData()
        }
    }
    
    func exportReport(type: ReportType, timeRange: TimeRange) {
        // In a real app, this would export the report to PDF/CSV
        print("Exporting \(type.rawValue) report for \(timeRange.rawValue)")
    }
    
    private func generateUserActivityData(timeRange: TimeRange) -> UserActivityData {
        let dailyActivity = [
            ChartDataPoint(label: "Mon", value: Double.random(in: 10...50)),
            ChartDataPoint(label: "Tue", value: Double.random(in: 10...50)),
            ChartDataPoint(label: "Wed", value: Double.random(in: 10...50)),
            ChartDataPoint(label: "Thu", value: Double.random(in: 10...50)),
            ChartDataPoint(label: "Fri", value: Double.random(in: 10...50)),
            ChartDataPoint(label: "Sat", value: Double.random(in: 5...30)),
            ChartDataPoint(label: "Sun", value: Double.random(in: 5...30))
        ]
        
        return UserActivityData(
            activeUsers: Int.random(in: 50...200),
            newUsers: Int.random(in: 5...20),
            loginSessions: Int.random(in: 100...500),
            failedLogins: Int.random(in: 5...25),
            dailyActivity: dailyActivity
        )
    }
    
    private func generateShiftPerformanceData(timeRange: TimeRange) -> ShiftPerformanceData {
        let totalShifts = Int.random(in: 100...500)
        let completedShifts = Int.random(in: 80...totalShifts)
        let onTimeShifts = Int.random(in: 70...completedShifts)
        let lateShifts = completedShifts - onTimeShifts
        
        return ShiftPerformanceData(
            totalShifts: totalShifts,
            completedShifts: completedShifts,
            onTimeShifts: onTimeShifts,
            lateShifts: lateShifts,
            completionRate: Double(completedShifts) / Double(totalShifts),
            onTimeRate: Double(onTimeShifts) / Double(completedShifts)
        )
    }
    
    private func generateFinancialData(timeRange: TimeRange) -> FinancialData {
        let totalRevenue = String(format: "%.2f", Double.random(in: 10000...50000))
        let totalExpenses = String(format: "%.2f", Double.random(in: 5000...30000))
        let netProfit = String(format: "%.2f", Double(totalRevenue)! - Double(totalExpenses)!)
        let pendingPayments = String(format: "%.2f", Double.random(in: 1000...5000))
        
        let revenueTrend = [
            ChartDataPoint(label: "Jan", value: Double.random(in: 5000...15000)),
            ChartDataPoint(label: "Feb", value: Double.random(in: 5000...15000)),
            ChartDataPoint(label: "Mar", value: Double.random(in: 5000...15000)),
            ChartDataPoint(label: "Apr", value: Double.random(in: 5000...15000)),
            ChartDataPoint(label: "May", value: Double.random(in: 5000...15000)),
            ChartDataPoint(label: "Jun", value: Double.random(in: 5000...15000))
        ]
        
        return FinancialData(
            totalRevenue: totalRevenue,
            totalExpenses: totalExpenses,
            netProfit: netProfit,
            pendingPayments: pendingPayments,
            revenueTrend: revenueTrend
        )
    }
    
    private func generateSystemHealthData() -> SystemHealthData {
        return SystemHealthData(
            uptime: Double.random(in: 0.95...0.999),
            avgResponseTime: Int.random(in: 50...200),
            errorRate: Double.random(in: 0.001...0.05),
            activeSessions: Int.random(in: 10...100),
            systemStatus: .healthy
        )
    }
}

struct AuditsView: View {
    @StateObject private var viewModel = AuditsViewModel()
    @State private var selectedFilter: AuditFilter = .all
    @State private var searchText = ""
    @State private var showingDatePicker = false
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search and Filter Bar
                VStack(spacing: 12) {
                    SearchBar(text: $searchText, placeholder: "Search audit logs...")
                    
                    HStack {
                        Picker("Filter", selection: $selectedFilter) {
                            ForEach(AuditFilter.allCases, id: \.self) { filter in
                                Text(filter.rawValue).tag(filter)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Button(action: { showingDatePicker = true }) {
                            Image(systemName: "calendar")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                // Audit List
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading audit logs...")
                    Spacer()
                } else {
                    List {
                        ForEach(filteredAudits, id: \.id) { audit in
                            AuditRowView(audit: audit)
                        }
                    }
                    .refreshable {
                        await viewModel.loadAudits()
                    }
                    .overlay(
                        Group {
                            if filteredAudits.isEmpty {
                                VStack(spacing: 16) {
                                    Image(systemName: "doc.text.slash")
                                        .font(.system(size: 48))
                                        .foregroundColor(.secondary)
                                    Text("No audit logs found")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                    Text("Try adjusting your search or filters")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                            }
                        }
                    )
                }
            }
            .navigationTitle("Audit Log")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Export") {
                        viewModel.exportAudits()
                    }
                }
            }
            .sheet(isPresented: $showingDatePicker) {
                DatePickerView(selectedDate: $selectedDate) {
                    viewModel.filterByDate(selectedDate)
                    showingDatePicker = false
                }
            }
            .task {
                await viewModel.loadAudits()
            }
        }
    }
    
    private var filteredAudits: [AuditLog] {
        let filtered = viewModel.filteredAudits(by: selectedFilter)
        if searchText.isEmpty {
            return filtered
        } else {
            return filtered.filter { audit in
                audit.action.lowercased().contains(searchText.lowercased()) ||
                audit.userEmail.lowercased().contains(searchText.lowercased()) ||
                audit.details.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

struct AuditRowView: View {
    let audit: AuditLog
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: auditIcon)
                    .foregroundColor(auditColor)
                    .frame(width: 20)
                
                Text(audit.action)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text(audit.timestamp)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text(audit.details)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Text("User: \(audit.userEmail)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(audit.ipAddress)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
    
    private var auditIcon: String {
        switch audit.type {
        case .user: return "person"
        case .shift: return "clock"
        case .system: return "gearshape"
        case .security: return "lock"
        }
    }
    
    private var auditColor: Color {
        switch audit.type {
        case .user: return .blue
        case .shift: return .green
        case .system: return .orange
        case .security: return .red
        }
    }
}

struct DatePickerView: View {
    @Binding var selectedDate: Date
    let onDone: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "Select Date",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                
                Spacer()
            }
            .navigationTitle("Select Date")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        onDone()
                    }
                }
            }
        }
    }
}

// MARK: - Audit Data Models

enum AuditFilter: String, CaseIterable {
    case all = "All"
    case user = "User"
    case shift = "Shift"
    case system = "System"
    case security = "Security"
}

enum AuditType: String {
    case user = "USER"
    case shift = "SHIFT"
    case system = "SYSTEM"
    case security = "SECURITY"
}

struct AuditLog: Identifiable {
    let id = UUID()
    let action: String
    let details: String
    let userEmail: String
    let ipAddress: String
    let type: AuditType
    let timestamp: String
    let date: Date
}

// MARK: - Audits View Model

@MainActor
class AuditsViewModel: ObservableObject {
    @Published var audits: [AuditLog] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadAudits() async {
        isLoading = true
        errorMessage = nil
        
        // In a real app, this would load from a database
        // For now, we'll create mock data
        audits = generateMockAudits()
        
        isLoading = false
    }
    
    func filteredAudits(by filter: AuditFilter) -> [AuditLog] {
        switch filter {
        case .all:
            return audits
        case .user:
            return audits.filter { $0.type == .user }
        case .shift:
            return audits.filter { $0.type == .shift }
        case .system:
            return audits.filter { $0.type == .system }
        case .security:
            return audits.filter { $0.type == .security }
        }
    }
    
    func filterByDate(_ date: Date) {
        // In real app, this would filter by the selected date
        print("Filtering by date: \(date)")
    }
    
    func exportAudits() {
        // In real app, this would export audit logs to a file
        print("Exporting audit logs...")
    }
    
    private func generateMockAudits() -> [AuditLog] {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return [
            AuditLog(
                action: "User Login",
                details: "Successful login from mobile app",
                userEmail: "admin@example.com",
                ipAddress: "192.168.1.100",
                type: .security,
                timestamp: formatter.string(from: Date().addingTimeInterval(-300)),
                date: Date().addingTimeInterval(-300)
            ),
            AuditLog(
                action: "User Created",
                details: "New user account created: jane.doe@example.com",
                userEmail: "admin@example.com",
                ipAddress: "192.168.1.100",
                type: .user,
                timestamp: formatter.string(from: Date().addingTimeInterval(-1800)),
                date: Date().addingTimeInterval(-1800)
            ),
            AuditLog(
                action: "Shift Assigned",
                details: "Shift 'Night Security' assigned to Guard #1234",
                userEmail: "manager@example.com",
                ipAddress: "192.168.1.101",
                type: .shift,
                timestamp: formatter.string(from: Date().addingTimeInterval(-3600)),
                date: Date().addingTimeInterval(-3600)
            ),
            AuditLog(
                action: "System Backup",
                details: "Automatic database backup completed successfully",
                userEmail: "system@guardapp.com",
                ipAddress: "10.0.0.1",
                type: .system,
                timestamp: formatter.string(from: Date().addingTimeInterval(-7200)),
                date: Date().addingTimeInterval(-7200)
            ),
            AuditLog(
                action: "Failed Login Attempt",
                details: "Invalid password for user: unknown@example.com",
                userEmail: "unknown@example.com",
                ipAddress: "203.0.113.45",
                type: .security,
                timestamp: formatter.string(from: Date().addingTimeInterval(-10800)),
                date: Date().addingTimeInterval(-10800)
            ),
            AuditLog(
                action: "User Role Changed",
                details: "User role changed from Guard to Manager",
                userEmail: "admin@example.com",
                ipAddress: "192.168.1.100",
                type: .user,
                timestamp: formatter.string(from: Date().addingTimeInterval(-14400)),
                date: Date().addingTimeInterval(-14400)
            ),
            AuditLog(
                action: "Shift Completed",
                details: "Shift 'Day Security' marked as completed",
                userEmail: "guard@example.com",
                ipAddress: "192.168.1.102",
                type: .shift,
                timestamp: formatter.string(from: Date().addingTimeInterval(-21600)),
                date: Date().addingTimeInterval(-21600)
            ),
            AuditLog(
                action: "Settings Updated",
                details: "System settings modified: Email notifications enabled",
                userEmail: "admin@example.com",
                ipAddress: "192.168.1.100",
                type: .system,
                timestamp: formatter.string(from: Date().addingTimeInterval(-28800)),
                date: Date().addingTimeInterval(-28800)
            )
        ]
    }
}

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section("System Configuration") {
                    Toggle("Enable Email Notifications", isOn: $viewModel.emailNotifications)
                    Toggle("Enable Push Notifications", isOn: $viewModel.pushNotifications)
                    Toggle("Auto-backup Database", isOn: $viewModel.autoBackup)
                    Toggle("Debug Mode", isOn: $viewModel.debugMode)
                }
                
                Section("Security Settings") {
                    Toggle("Require Two-Factor Authentication", isOn: $viewModel.require2FA)
                    Toggle("Session Timeout", isOn: $viewModel.sessionTimeout)
                    
                    if viewModel.sessionTimeout {
                        Picker("Timeout Duration", selection: $viewModel.sessionTimeoutDuration) {
                            Text("15 minutes").tag(15)
                            Text("30 minutes").tag(30)
                            Text("1 hour").tag(60)
                            Text("4 hours").tag(240)
                        }
                    }
                }
                
                Section("Data Management") {
                    Button("Export All Data") {
                        viewModel.exportData()
                    }
                    .foregroundColor(.blue)
                    
                    Button("Clear Cache") {
                        viewModel.clearCache()
                    }
                    .foregroundColor(.orange)
                    
                    Button("Reset to Defaults") {
                        viewModel.showingResetAlert = true
                    }
                    .foregroundColor(.red)
                }
                
                Section("System Information") {
                    HStack {
                        Text("App Version")
                        Spacer()
                        Text(viewModel.appVersion)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Database Version")
                        Spacer()
                        Text(viewModel.databaseVersion)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Last Backup")
                        Spacer()
                        Text(viewModel.lastBackup)
                            .foregroundColor(.secondary)
                    }
                }
                
                Section("Support") {
                    Button("Contact Support") {
                        viewModel.contactSupport()
                    }
                    .foregroundColor(.blue)
                    
                    Button("View Documentation") {
                        viewModel.viewDocumentation()
                    }
                    .foregroundColor(.blue)
                    
                    Button("Report Bug") {
                        viewModel.reportBug()
                    }
                    .foregroundColor(.blue)
                }
            }
            .navigationTitle("Settings")
            .alert("Reset Settings", isPresented: $viewModel.showingResetAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Reset", role: .destructive) {
                    viewModel.resetToDefaults()
                }
            } message: {
                Text("Are you sure you want to reset all settings to their default values? This action cannot be undone.")
            }
            .alert("Success", isPresented: $viewModel.showingSuccessAlert) {
                Button("OK") { }
            } message: {
                Text(viewModel.successMessage)
            }
        }
    }
}

// MARK: - Settings View Model

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var emailNotifications = true
    @Published var pushNotifications = true
    @Published var autoBackup = true
    @Published var debugMode = false
    @Published var require2FA = false
    @Published var sessionTimeout = true
    @Published var sessionTimeoutDuration = 30
    @Published var showingResetAlert = false
    @Published var showingSuccessAlert = false
    @Published var successMessage = ""
    
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    var databaseVersion: String {
        "1.0.0" // In real app, this would come from the database
    }
    
    var lastBackup: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: Date().addingTimeInterval(-86400)) // Mock: 1 day ago
    }
    
    func exportData() {
        // In real app, this would export data to a file
        successMessage = "Data exported successfully"
        showingSuccessAlert = true
    }
    
    func clearCache() {
        // In real app, this would clear the app cache
        successMessage = "Cache cleared successfully"
        showingSuccessAlert = true
    }
    
    func resetToDefaults() {
        emailNotifications = true
        pushNotifications = true
        autoBackup = true
        debugMode = false
        require2FA = false
        sessionTimeout = true
        sessionTimeoutDuration = 30
        
        successMessage = "Settings reset to defaults"
        showingSuccessAlert = true
    }
    
    func contactSupport() {
        // In real app, this would open email or support chat
        if let url = URL(string: "mailto:support@guardapp.com") {
            UIApplication.shared.open(url)
        }
    }
    
    func viewDocumentation() {
        // In real app, this would open documentation
        if let url = URL(string: "https://docs.guardapp.com") {
            UIApplication.shared.open(url)
        }
    }
    
    func reportBug() {
        // In real app, this would open bug reporting interface
        if let url = URL(string: "mailto:bugs@guardapp.com") {
            UIApplication.shared.open(url)
        }
    }
}
