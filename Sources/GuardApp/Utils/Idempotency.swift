import Foundation

struct Idempotency {
    static func newKey() -> String {
        // Simple ULID-ish stub for now; replace with a proper ULID if needed
        return UUID().uuidString
    }
}