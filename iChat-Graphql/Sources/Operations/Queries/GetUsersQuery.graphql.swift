// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetUsersQuery: GraphQLQuery {
  public static let operationName: String = "GetUsers"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetUsers { list: getUsers { __typename id fullname avatar isSelf email } }"#
    ))

  public init() {}

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getUsers", alias: "list", [List].self),
    ] }

    public var list: [List] { __data["list"] }

    /// List
    ///
    /// Parent Type: `User`
    public struct List: Ichatgl.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.User }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("fullname", String.self),
        .field("avatar", String?.self),
        .field("isSelf", Bool.self),
        .field("email", String.self),
      ] }

      public var id: Int { __data["id"] }
      public var fullname: String { __data["fullname"] }
      public var avatar: String? { __data["avatar"] }
      public var isSelf: Bool { __data["isSelf"] }
      public var email: String { __data["email"] }
    }
  }
}
