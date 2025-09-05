import Foundation
import Amplify

// Import generated Amplify models
// The generated models are now available in src/models/
// Use the generated User, Shift, Role, and ShiftState models from Amplify

// Legacy models for backward compatibility (can be removed once migration is complete)
enum LegacyRole: String, Codable, CaseIterable {
    case admin, businessOwner, businessStaff, worker
}

struct UserClaims: Codable, Equatable, Sendable {
    let userId: String
    let tenantId: String
    let role: Role
    let issuedAt: Date
    let expiresAt: Date
}

struct LegacyShift: Codable, Equatable, Identifiable, Sendable {
    let id: String
    let tenantId: String
    let title: String
    let location: String
    let startAt: Date
    let endAt: Date
    let rate: Decimal
    let state: LegacyShiftState
}

enum LegacyShiftState: String, Codable, CaseIterable {
    case draft, open, requested, assigned, completed, disputed, closed
}