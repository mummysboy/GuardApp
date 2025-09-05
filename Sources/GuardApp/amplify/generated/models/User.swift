// swiftlint:disable all
import Amplify
import Foundation

public struct User: Model {
  public let id: String
  public var tenantId: String
  public var role: Role
  public var email: String
  public var firstName: String?
  public var lastName: String?
  public var phone: String?
  public var createdAt: Temporal.DateTime
  public var updatedAt: Temporal.DateTime
  public var _version: Int
  public var _deleted: Bool?
  public var _lastChangedAt: Int
  
  public init(id: String = UUID().uuidString,
      tenantId: String,
      role: Role,
      email: String,
      firstName: String? = nil,
      lastName: String? = nil,
      phone: String? = nil,
      createdAt: Temporal.DateTime,
      updatedAt: Temporal.DateTime,
      _version: Int,
      _deleted: Bool? = nil,
      _lastChangedAt: Int) {
      self.id = id
      self.tenantId = tenantId
      self.role = role
      self.email = email
      self.firstName = firstName
      self.lastName = lastName
      self.phone = phone
      self.createdAt = createdAt
      self.updatedAt = updatedAt
      self._version = _version
      self._deleted = _deleted
      self._lastChangedAt = _lastChangedAt
  }
}