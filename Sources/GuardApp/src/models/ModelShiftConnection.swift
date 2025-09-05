// swiftlint:disable all
import Amplify
import Foundation

public struct ModelShiftConnection: Embeddable {
  var items: [Shift?]
  var nextToken: String?
  var startedAt: Int?
}