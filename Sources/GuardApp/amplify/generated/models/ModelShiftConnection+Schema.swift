// swiftlint:disable all
import Amplify
import Foundation

extension ModelShiftConnection {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case items
    case nextToken
    case startedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let modelShiftConnection = ModelShiftConnection.keys
    
    model.listPluralName = "ModelShiftConnections"
    model.syncPluralName = "ModelShiftConnections"
    
    model.fields(
      .field(modelShiftConnection.items, is: .required, ofType: .collection(of: Shift.self)),
      .field(modelShiftConnection.nextToken, is: .optional, ofType: .string),
      .field(modelShiftConnection.startedAt, is: .optional, ofType: .int)
    )
    }
}