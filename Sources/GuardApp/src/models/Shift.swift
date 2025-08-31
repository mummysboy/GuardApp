// swiftlint:disable all
import Amplify
import Foundation

public struct Shift: Model {
  public let id: String
  public var tenantId: String
  public var title: String
  public var location: String
  public var startAt: Temporal.DateTime
  public var endAt: Temporal.DateTime
  public var rate: Double
  public var state: ShiftState
  public var user: User?
  public var createdAt: Temporal.DateTime
  public var updatedAt: Temporal.DateTime
  
  public init(id: String = UUID().uuidString,
      tenantId: String,
      title: String,
      location: String,
      startAt: Temporal.DateTime,
      endAt: Temporal.DateTime,
      rate: Double,
      state: ShiftState,
      user: User? = nil,
      createdAt: Temporal.DateTime,
      updatedAt: Temporal.DateTime) {
      self.id = id
      self.tenantId = tenantId
      self.title = title
      self.location = location
      self.startAt = startAt
      self.endAt = endAt
      self.rate = rate
      self.state = state
      self.user = user
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}