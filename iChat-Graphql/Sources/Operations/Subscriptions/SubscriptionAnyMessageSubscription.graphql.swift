// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SubscriptionAnyMessageSubscription: GraphQLSubscription {
  public static let operationName: String = "SubscriptionAnyMessage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription SubscriptionAnyMessage { allMessages { __typename ... on Message { id content } } }"#
    ))

  public init() {}

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.SubscriptionRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("allMessages", AllMessages.self),
    ] }

    public var allMessages: AllMessages { __data["allMessages"] }

    /// AllMessages
    ///
    /// Parent Type: `AppEvent`
    public struct AllMessages: Ichatgl.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Unions.AppEvent }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .inlineFragment(AsMessage.self),
      ] }

      public var asMessage: AsMessage? { _asInlineFragment() }

      /// AllMessages.AsMessage
      ///
      /// Parent Type: `Message`
      public struct AsMessage: Ichatgl.InlineFragment {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public typealias RootEntityType = SubscriptionAnyMessageSubscription.Data.AllMessages
        public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.Message }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("id", Int.self),
          .field("content", String.self),
        ] }

        public var id: Int { __data["id"] }
        public var content: String { __data["content"] }
      }
    }
  }
}
