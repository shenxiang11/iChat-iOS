// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateChatMutation: GraphQLMutation {
  public static let operationName: String = "CreateChat"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateChat($memberIds: [Int!]!) { createChat(memberIds: $memberIds) { __typename id name } }"#
    ))

  public var memberIds: [Int]

  public init(memberIds: [Int]) {
    self.memberIds = memberIds
  }

  public var __variables: Variables? { ["memberIds": memberIds] }

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.MutationRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createChat", CreateChat.self, arguments: ["memberIds": .variable("memberIds")]),
    ] }

    public var createChat: CreateChat { __data["createChat"] }

    /// CreateChat
    ///
    /// Parent Type: `Chat`
    public struct CreateChat: Ichatgl.SelectionSet {
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
}
