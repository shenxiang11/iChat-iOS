// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetUserQuery: GraphQLQuery {
  public static let operationName: String = "GetUser"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetUser { getSelf { __typename id fullname avatar email } }"#
    ))

  public init() {}

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getSelf", GetSelf.self),
    ] }

    public var getSelf: GetSelf { __data["getSelf"] }

    /// GetSelf
    ///
    /// Parent Type: `User`
    public struct GetSelf: Ichatgl.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.User }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("fullname", String.self),
        .field("avatar", String?.self),
        .field("email", String.self),
      ] }

      public var id: Int { __data["id"] }
      public var fullname: String { __data["fullname"] }
      public var avatar: String? { __data["avatar"] }
      public var email: String { __data["email"] }
    }
  }
}
