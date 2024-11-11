// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct MessageDetail: Ichatgl.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment MessageDetail on Message { __typename id content isMine user { __typename id fullname avatar email } createdAt }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.Message }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", Int.self),
    .field("content", String.self),
    .field("isMine", Bool.self),
    .field("user", User.self),
    .field("createdAt", Ichatgl.DateTime.self),
  ] }

  public var id: Int { __data["id"] }
  public var content: String { __data["content"] }
  public var isMine: Bool { __data["isMine"] }
  public var user: User { __data["user"] }
  public var createdAt: Ichatgl.DateTime { __data["createdAt"] }

  /// User
  ///
  /// Parent Type: `User`
  public struct User: Ichatgl.SelectionSet {
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
