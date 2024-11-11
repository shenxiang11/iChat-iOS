// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SetReadedMutation: GraphQLMutation {
  public static let operationName: String = "SetReaded"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SetReaded($chatId: Int!) { chatRead(chatId: $chatId) }"#
    ))

  public var chatId: Int

  public init(chatId: Int) {
    self.chatId = chatId
  }

  public var __variables: Variables? { ["chatId": chatId] }

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.MutationRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("chatRead", Bool.self, arguments: ["chatId": .variable("chatId")]),
    ] }

    public var chatRead: Bool { __data["chatRead"] }
  }
}
