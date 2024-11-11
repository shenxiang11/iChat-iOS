// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateChatNameMutation: GraphQLMutation {
  public static let operationName: String = "UpdateChatName"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateChatName($id: Int!, $name: String!) { updateChatName(chatId: $id, name: $name) }"#
    ))

  public var id: Int
  public var name: String

  public init(
    id: Int,
    name: String
  ) {
    self.id = id
    self.name = name
  }

  public var __variables: Variables? { [
    "id": id,
    "name": name
  ] }

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.MutationRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("updateChatName", Bool.self, arguments: [
        "chatId": .variable("id"),
        "name": .variable("name")
      ]),
    ] }

    public var updateChatName: Bool { __data["updateChatName"] }
  }
}
