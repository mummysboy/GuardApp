// swiftlint:disable all
import Amplify
import Foundation

public enum ShiftState: String, EnumPersistable {
  case draft = "DRAFT"
  case open = "OPEN"
  case requested = "REQUESTED"
  case assigned = "ASSIGNED"
  case completed = "COMPLETED"
  case disputed = "DISPUTED"
  case closed = "CLOSED"
}