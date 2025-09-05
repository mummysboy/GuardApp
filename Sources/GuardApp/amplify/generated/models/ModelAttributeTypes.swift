// swiftlint:disable all
import Amplify
import Foundation

public enum ModelAttributeTypes: String, EnumPersistable {
  case binary
  case binarySet
  case bool
  case list
  case map
  case number
  case numberSet
  case string
  case stringSet
  case null = "_null"
}