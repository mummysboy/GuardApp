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
  public var userId: String
  public var createdAt: Temporal.DateTime
  public var updatedAt: Temporal.DateTime
  public var _version: Int
  public var _deleted: Bool?
  public var _lastChangedAt: Int
  
  public init(id: String = UUID().uuidString,
      tenantId: String,
      title: String,
      location: String,
      startAt: Temporal.DateTime,
      endAt: Temporal.DateTime,
      rate: Double,
      state: ShiftState,
      userId: String,
      createdAt: Temporal.DateTime,
      updatedAt: Temporal.DateTime,
      _version: Int,
      _deleted: Bool? = nil,
      _lastChangedAt: Int) {
      self.id = id
      self.tenantId = tenantId
      self.title = title
      self.location = location
      self.startAt = startAt
      self.endAt = endAt
      self.rate = rate
      self.state = state
      self.userId = userId
      self.createdAt = createdAt
      self.updatedAt = updatedAt
      self._version = _version
      self._deleted = _deleted
      self._lastChangedAt = _lastChangedAt
  }
}