// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SubscriptionChatSubscription: GraphQLSubscription {
  public static let operationName: String = "SubscriptionChat"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription SubscriptionChat { chat { __typename ... on CreatedChat { chat: data { __typename id name owner { __typename id } } } ... on ChatNameChanged { chat: data { __typename id name } } ... on ChatOwnerChanged { chat: data { __typename owner { __typename id } } } ... on ChatDeleted { data: data { __typename id } } } }"#
    ))

  public init() {}

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.SubscriptionRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("chat", Chat.self),
    ] }

    public var chat: Chat { __data["chat"] }

    /// Chat
    ///
    /// Parent Type: `AppEvent`
    public struct Chat: Ichatgl.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Unions.AppEvent }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .inlineFragment(AsCreatedChat.self),
        .inlineFragment(AsChatNameChanged.self),
        .inlineFragment(AsChatOwnerChanged.self),
        .inlineFragment(AsChatDeleted.self),
      ] }

      public var asCreatedChat: AsCreatedChat? { _asInlineFragment() }
      public var asChatNameChanged: AsChatNameChanged? { _asInlineFragment() }
      public var asChatOwnerChanged: AsChatOwnerChanged? { _asInlineFragment() }
      public var asChatDeleted: AsChatDeleted? { _asInlineFragment() }

      /// Chat.AsCreatedChat
      ///
      /// Parent Type: `CreatedChat`
      public struct AsCreatedChat: Ichatgl.InlineFragment {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public typealias RootEntityType = SubscriptionChatSubscription.Data.Chat
        public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.CreatedChat }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("data", alias: "chat", Chat.self),
        ] }

        public var chat: Chat { __data["chat"] }

        /// Chat.AsCreatedChat.Chat
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
            .field("owner", Owner.self),
          ] }

          public var id: Int { __data["id"] }
          public var name: String { __data["name"] }
          public var owner: Owner { __data["owner"] }

          /// Chat.AsCreatedChat.Chat.Owner
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
        }
      }

      /// Chat.AsChatNameChanged
      ///
      /// Parent Type: `ChatNameChanged`
      public struct AsChatNameChanged: Ichatgl.InlineFragment {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public typealias RootEntityType = SubscriptionChatSubscription.Data.Chat
        public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.ChatNameChanged }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("data", alias: "chat", Chat.self),
        ] }

        public var chat: Chat { __data["chat"] }

        /// Chat.AsChatNameChanged.Chat
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
          ] }

          public var id: Int { __data["id"] }
          public var name: String { __data["name"] }
        }
      }

      /// Chat.AsChatOwnerChanged
      ///
      /// Parent Type: `ChatOwnerChanged`
      public struct AsChatOwnerChanged: Ichatgl.InlineFragment {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public typealias RootEntityType = SubscriptionChatSubscription.Data.Chat
        public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.ChatOwnerChanged }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("data", alias: "chat", Chat.self),
        ] }

        public var chat: Chat { __data["chat"] }

        /// Chat.AsChatOwnerChanged.Chat
        ///
        /// Parent Type: `Chat`
        public struct Chat: Ichatgl.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.Chat }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("owner", Owner.self),
          ] }

          public var owner: Owner { __data["owner"] }

          /// Chat.AsChatOwnerChanged.Chat.Owner
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
        }
      }

      /// Chat.AsChatDeleted
      ///
      /// Parent Type: `ChatDeleted`
      public struct AsChatDeleted: Ichatgl.InlineFragment {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public typealias RootEntityType = SubscriptionChatSubscription.Data.Chat
        public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.ChatDeleted }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("data", alias: "data", Data.self),
        ] }

        public var data: Data { __data["data"] }

        /// Chat.AsChatDeleted.Data
        ///
        /// Parent Type: `Chat`
        public struct Data: Ichatgl.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.Chat }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Int.self),
          ] }

          public var id: Int { __data["id"] }
        }
      }
    }
  }
}
