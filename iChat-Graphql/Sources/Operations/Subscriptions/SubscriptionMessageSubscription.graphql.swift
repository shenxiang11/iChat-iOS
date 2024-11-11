// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SubscriptionMessageSubscription: GraphQLSubscription {
  public static let operationName: String = "SubscriptionMessage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription SubscriptionMessage($chatId: Int!) { message(chatId: $chatId) { __typename ... on Message { ...MessageDetail } } }"#,
      fragments: [MessageDetail.self]
    ))

  public var chatId: Int

  public init(chatId: Int) {
    self.chatId = chatId
  }

  public var __variables: Variables? { ["chatId": chatId] }

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.SubscriptionRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("message", Message.self, arguments: ["chatId": .variable("chatId")]),
    ] }

    public var message: Message { __data["message"] }

    /// Message
    ///
    /// Parent Type: `AppEvent`
    public struct Message: Ichatgl.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Unions.AppEvent }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .inlineFragment(AsMessage.self),
      ] }

      public var asMessage: AsMessage? { _asInlineFragment() }

      /// Message.AsMessage
      ///
      /// Parent Type: `Message`
      public struct AsMessage: Ichatgl.InlineFragment {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public typealias RootEntityType = SubscriptionMessageSubscription.Data.Message
        public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.Message }
        public static var __selections: [ApolloAPI.Selection] { [
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
}
