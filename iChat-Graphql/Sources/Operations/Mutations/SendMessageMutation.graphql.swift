// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SendMessageMutation: GraphQLMutation {
  public static let operationName: String = "SendMessage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SendMessage($req: CreateMessage!) { message: sendMessage(input: $req) { __typename id content } }"#
    ))

  public var req: CreateMessage

  public init(req: CreateMessage) {
    self.req = req
  }

  public var __variables: Variables? { ["req": req] }

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.MutationRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("sendMessage", alias: "message", Message.self, arguments: ["input": .variable("req")]),
    ] }

    public var message: Message { __data["message"] }

    /// Message
    ///
    /// Parent Type: `Message`
    public struct Message: Ichatgl.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.Message }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("content", String.self),
      ] }

      public var id: Int { __data["id"] }
      public var content: String { __data["content"] }
    }
  }
}
