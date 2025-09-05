// swiftlint:disable all
import Amplify
import Foundation

extension ModelUserConnection {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case items
    case nextToken
    case startedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let modelUserConnection = ModelUserConnection.keys
    
    model.listPluralName = "ModelUserConnections"
    model.syncPluralName = "ModelUserConnections"
    
    model.fields(
      .field(modelUserConnection.items, is: .required, ofType: .collection(of: User.self)),
      .field(modelUserConnection.nextToken, is: .optional, ofType: .string),
      .field(modelUserConnection.startedAt, is: .optional, ofType: .int)
    )
    }
}