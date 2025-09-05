// swiftlint:disable all
import Amplify
import Foundation

public enum Role: String, EnumPersistable {
  case admin = "ADMIN"
  case securityGuard = "SECURITY_GUARD"
  case supervisor = "SUPERVISOR"
}