// swiftlint:disable all
import Amplify
import Foundation

public enum Role: String, EnumPersistable {
  case admin = "ADMIN"
  case businessOwner = "BUSINESS_OWNER"
  case businessStaff = "BUSINESS_STAFF"
  case worker = "WORKER"
}