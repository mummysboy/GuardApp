// swiftlint:disable all
import Amplify
import Foundation

extension User {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case tenantId
    case role
    case email
    case firstName
    case lastName
    case phone
    case createdAt
    case updatedAt
    case shifts
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let user = User.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", provider: .userPools, operations: [.create, .update, .delete, .read])
    ]
    
    model.listPluralName = "Users"
    model.syncPluralName = "Users"
    
    model.attributes(
      .primaryKey(fields: [user.id])
    )
    
    model.fields(
      .field(user.id, is: .required, ofType: .string),
      .field(user.tenantId, is: .required, ofType: .string),
      .field(user.role, is: .required, ofType: .enum(type: Role.self)),
      .field(user.email, is: .required, ofType: .string),
      .field(user.firstName, is: .optional, ofType: .string),
      .field(user.lastName, is: .optional, ofType: .string),
      .field(user.phone, is: .optional, ofType: .string),
      .field(user.createdAt, is: .required, ofType: .dateTime),
      .field(user.updatedAt, is: .required, ofType: .dateTime),
      .hasMany(user.shifts, is: .optional, ofType: Shift.self, associatedWith: Shift.keys.user)
    )
    }
}

extension User: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}