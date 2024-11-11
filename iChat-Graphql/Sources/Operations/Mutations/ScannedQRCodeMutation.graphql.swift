// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ScannedQRCodeMutation: GraphQLMutation {
  public static let operationName: String = "ScannedQRCode"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation ScannedQRCode($deviceUuid: String!) { scanned(deviceUuid: $deviceUuid) }"#
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
      .field("scanned", Bool.self, arguments: ["deviceUuid": .variable("deviceUuid")]),
    ] }

    public var scanned: Bool { __data["scanned"] }
  }
}
