// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetMessagesQuery: GraphQLQuery {
  public static let operationName: String = "GetMessages"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetMessages($chatId: Int!, $cursorId: Int) { chat: getChat(id: $chatId) { __typename id name type original9Users { __typename id fullname avatar isSelf } } messages: getMessages(chatId: $chatId, cursorId: $cursorId) { __typename ...MessageDetail } }"#,
      fragments: [MessageDetail.self]
    ))

  public var chatId: Int
  public var cursorId: GraphQLNullable<Int>

  public init(
    chatId: Int,
    cursorId: GraphQLNullable<Int>
  ) {
    self.chatId = chatId
    self.cursorId = cursorId
  }

  public var __variables: Variables? { [
    "chatId": chatId,
    "cursorId": cursorId
  ] }

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getChat", alias: "chat", Chat.self, arguments: ["id": .variable("chatId")]),
      .field("getMessages", alias: "messages", [Message].self, arguments: [
        "chatId": .variable("chatId"),
        "cursorId": .variable("cursorId")
      ]),
    ] }

    public var chat: Chat { __data["chat"] }
    public var messages: [Message] { __data["messages"] }

    /// Chat
    ///
    /// Parent Type: `Chat`
    public struct Chat: Ichatgl.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.Chat }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("name", String.self),
        .field("type", GraphQLEnum<Ichatgl.ChatType>.self),
        .field("original9Users", [Original9User].self),
      ] }

      public var id: Int { __data["id"] }
      public var name: String { __data["name"] }
      public var type: GraphQLEnum<Ichatgl.ChatType> { __data["type"] }
      public var original9Users: [Original9User] { __data["original9Users"] }

      /// Chat.Original9User
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
    }

    /// Message
    ///
    /// Parent Type: `Message`
    public struct Message: Ichatgl.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.Message }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(MessageDetail.self),
      ] }

      public var id: Int { __data["id"] }
      public var content: String { __data["content"] }
      public var isMine: Bool { __data["isMine"] }
      public var user: User { __data["user"] }
      public var createdAt: Ichatgl.DateTime { __data["createdAt"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var messageDetail: MessageDetail { _toFragment() }
      }

      public typealias User = MessageDetail.User
    }
  }
}
