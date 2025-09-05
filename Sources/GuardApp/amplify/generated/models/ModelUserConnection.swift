// swiftlint:disable all
import Amplify
import Foundation

public struct ModelUserConnection: Embeddable {
  var items: [User?]
  var nextToken: String?
  var startedAt: Int?
}