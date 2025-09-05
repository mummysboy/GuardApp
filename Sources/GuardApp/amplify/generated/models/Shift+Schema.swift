// swiftlint:disable all
import Amplify
import Foundation

extension Shift {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case tenantId
    case title
    case location
    case startAt
    case endAt
    case rate
    case state
    case userId
    case createdAt
    case updatedAt
    case _version
    case _deleted
    case _lastChangedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let shift = Shift.keys
    
    model.listPluralName = "Shifts"
    model.syncPluralName = "Shifts"
    
    model.attributes(
      .primaryKey(fields: [shift.id])
    )
    
    model.fields(
      .field(shift.id, is: .required, ofType: .string),
      .field(shift.tenantId, is: .required, ofType: .string),
      .field(shift.title, is: .required, ofType: .string),
      .field(shift.location, is: .required, ofType: .string),
      .field(shift.startAt, is: .required, ofType: .dateTime),
      .field(shift.endAt, is: .required, ofType: .dateTime),
      .field(shift.rate, is: .required, ofType: .double),
      .field(shift.state, is: .required, ofType: .enum(type: ShiftState.self)),
      .field(shift.userId, is: .required, ofType: .string),
      .field(shift.createdAt, is: .required, ofType: .dateTime),
      .field(shift.updatedAt, is: .required, ofType: .dateTime),
      .field(shift._version, is: .required, ofType: .int),
      .field(shift._deleted, is: .optional, ofType: .bool),
      .field(shift._lastChangedAt, is: .required, ofType: .int)
    )
    }
}

extension Shift: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}