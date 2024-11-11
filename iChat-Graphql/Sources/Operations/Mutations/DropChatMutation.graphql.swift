// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DropChatMutation: GraphQLMutation {
  public static let operationName: String = "DropChat"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DropChat($id: Int!) { dropChat(id: $id) }"#
    ))

  public var id: Int

  public init(id: Int) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.MutationRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("dropChat", Bool.self, arguments: ["id": .variable("id")]),
    ] }

    public var dropChat: Bool { __data["dropChat"] }
  }
}
