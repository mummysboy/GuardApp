// swiftlint:disable all
import Amplify
import Foundation

public enum ShiftState: String, EnumPersistable {
  case pending = "PENDING"
  case assigned = "ASSIGNED"
  case inProgress = "IN_PROGRESS"
  case completed = "COMPLETED"
  case cancelled = "CANCELLED"
}