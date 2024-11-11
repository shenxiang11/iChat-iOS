// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetChatsQuery: GraphQLQuery {
  public static let operationName: String = "GetChats"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetChats { list: getChats { __typename id name displayName unreadCount type owner { __typename id } original9Users { __typename id fullname avatar isSelf } members { __typename id fullname } latestMessage { __typename id type user { __typename id fullname } content } } }"#
    ))

  public init() {}

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getChats", alias: "list", [List].self),
    ] }

    public var list: [List] { __data["list"] }

    /// List
    ///
    /// Parent Type: `Chat`
    public struct List: Ichatgl.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.Chat }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("name", String.self),
        .field("displayName", String.self),
        .field("unreadCount", Int.self),
        .field("type", GraphQLEnum<Ichatgl.ChatType>.self),
        .field("owner", Owner.self),
        .field("original9Users", [Original9User].self),
        .field("members", [Member].self),
        .field("latestMessage", LatestMessage?.self),
      ] }

      public var id: Int { __data["id"] }
      public var name: String { __data["name"] }
      public var displayName: String { __data["displayName"] }
      public var unreadCount: Int { __data["unreadCount"] }
      public var type: GraphQLEnum<Ichatgl.ChatType> { __data["type"] }
      public var owner: Owner { __data["owner"] }
      public var original9Users: [Original9User] { __data["original9Users"] }
      public var members: [Member] { __data["members"] }
      public var latestMessage: LatestMessage? { __data["latestMessage"] }

      /// List.Owner
      ///
      /// Parent Type: `User`
      public struct Owner: Ichatgl.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
        ] }

        public var id: Int { __data["id"] }
      }

      /// List.Original9User
      ///
      /// Parent Type: `User`
      public struct Original9User: Ichatgl.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("fullname", String.self),
          .field("avatar", String?.self),
          .field("isSelf", Bool.self),
        ] }

        public var id: Int { __data["id"] }
        public var fullname: String { __data["fullname"] }
        public var avatar: String? { __data["avatar"] }
        public var isSelf: Bool { __data["isSelf"] }
      }

      /// List.Member
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
        ] }

        public var id: Int { __data["id"] }
        public var fullname: String { __data["fullname"] }
      }

      /// List.LatestMessage
      ///
      /// Parent Type: `Message`
      public struct LatestMessage: Ichatgl.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.Message }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("type", GraphQLEnum<Ichatgl.MessageType>.self),
          .field("user", User.self),
          .field("content", String.self),
        ] }

        public var id: Int { __data["id"] }
        public var type: GraphQLEnum<Ichatgl.MessageType> { __data["type"] }
        public var user: User { __data["user"] }
        public var content: String { __data["content"] }

        /// List.LatestMessage.User
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
          ] }

          public var id: Int { __data["id"] }
          public var fullname: String { __data["fullname"] }
        }
      }
    }
  }
}
