import Foundation
import Amplify

struct Page { let limit: Int = 20; let cursor: String? = nil }

protocol ShiftService {
    func openShifts(tenantId: String) async throws -> [Shift]
    func myShifts(userId: String) async throws -> [Shift]
    func requestShift(shiftId: String, idempotencyKey: String) async throws
}

final class MockShiftService: ShiftService {
    private let delay: UInt64 = 400_000_000 // 0.4s

    func openShifts(tenantId: String) async throws -> [Shift] {
        try await Task.sleep(nanoseconds: delay)
        return MockData.openShifts
    }

    func myShifts(userId: String) async throws -> [Shift] {
        try await Task.sleep(nanoseconds: delay)
        return MockData.myShifts
    }

    func requestShift(shiftId: String, idempotencyKey: String) async throws {
        try await Task.sleep(nanoseconds: delay)
        // no-op (pretend success)
    }
}

enum MockData {
    static let openShifts: [Shift] = [
        .init(id: "s1", tenantId: "t_abc", title: "Front Desk (Lobby A)", location: "SF – 101 Main St",
              startAt: Temporal.DateTime(Date().addingTimeInterval(3600)), endAt: Temporal.DateTime(Date().addingTimeInterval(3600*5)),
              rate: 28, state: .open, user: nil, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now()),
        .init(id: "s2", tenantId: "t_abc", title: "Event Security – Gala", location: "SF – Pier 27",
              startAt: Temporal.DateTime(Date().addingTimeInterval(3600*24)), endAt: Temporal.DateTime(Date().addingTimeInterval(3600*28)),
              rate: 35, state: .open, user: nil, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now()),
    ]
    static let myShifts: [Shift] = [
        .init(id: "m1", tenantId: "t_abc", title: "Night Shift – Warehouse", location: "Oakland",
              startAt: Temporal.DateTime(Date().addingTimeInterval(-3600*8)), endAt: Temporal.DateTime(Date().addingTimeInterval(-3600*4)),
              rate: 30, state: .completed, user: nil, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now()),
        .init(id: "m2", tenantId: "t_abc", title: "Retail – Saturday", location: "SF – Union Square",
              startAt: Temporal.DateTime(Date().addingTimeInterval(3600*48)), endAt: Temporal.DateTime(Date().addingTimeInterval(3600*56)),
              rate: 29, state: .assigned, user: nil, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now()),
    ]
}
