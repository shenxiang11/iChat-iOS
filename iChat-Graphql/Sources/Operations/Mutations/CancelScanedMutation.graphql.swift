// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CancelScanedMutation: GraphQLMutation {
  public static let operationName: String = "CancelScaned"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CancelScaned($deviceUuid: String!) { cancelScanned(deviceUuid: $deviceUuid) }"#
    ))

  public var deviceUuid: String

  public init(deviceUuid: String) {
    self.deviceUuid = deviceUuid
  }

  public var __variables: Variables? { ["deviceUuid": deviceUuid] }

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.MutationRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("cancelScanned", Bool.self, arguments: ["deviceUuid": .variable("deviceUuid")]),
    ] }

    public var cancelScanned: Bool { __data["cancelScanned"] }
  }
}
