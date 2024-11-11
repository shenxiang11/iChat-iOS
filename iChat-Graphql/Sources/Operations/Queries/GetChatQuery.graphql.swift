// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetChatQuery: GraphQLQuery {
  public static let operationName: String = "GetChat"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetChat($id: Int!) { getChat(id: $id) { __typename id name ownerId type isOwner members { __typename id fullname avatar email isSelf } } }"#
    ))

  public var id: Int

  public init(id: Int) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getChat", GetChat.self, arguments: ["id": .variable("id")]),
    ] }

    public var getChat: GetChat { __data["getChat"] }

    /// GetChat
    ///
    /// Parent Type: `Chat`
    public struct GetChat: Ichatgl.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.Chat }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("name", String.self),
        .field("ownerId", Int.self),
        .field("type", GraphQLEnum<Ichatgl.ChatType>.self),
        .field("isOwner", Bool.self),
        .field("members", [Member].self),
      ] }

      public var id: Int { __data["id"] }
      public var name: String { __data["name"] }
      public var ownerId: Int { __data["ownerId"] }
      public var type: GraphQLEnum<Ichatgl.ChatType> { __data["type"] }
      public var isOwner: Bool { __data["isOwner"] }
      public var members: [Member] { __data["members"] }

      /// GetChat.Member
      ///
      /// Parent Type: `User`
      public struct Member: Ichatgl.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("fullname", String.self),
          .field("avatar", String?.self),
          .field("email", String.self),
          .field("isSelf", Bool.self),
        ] }

        public var id: Int { __data["id"] }
        public var fullname: String { __data["fullname"] }
        public var avatar: String? { __data["avatar"] }
        public var email: String { __data["email"] }
        public var isSelf: Bool { __data["isSelf"] }
      }
    }
  }
}
