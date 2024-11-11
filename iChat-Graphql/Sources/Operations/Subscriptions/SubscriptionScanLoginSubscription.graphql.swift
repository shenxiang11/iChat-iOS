// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SubscriptionScanLoginSubscription: GraphQLSubscription {
  public static let operationName: String = "SubscriptionScanLogin"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription SubscriptionScanLogin($deviceUuid: String!) { scanLogin(deviceUuid: $deviceUuid) { __typename ... on QrcodeScanned { deviceUuid } ... on QrcodeConfirmed { token deviceUuid } ... on QrcodeCancel { deviceUuid } } }"#
    ))

  public var deviceUuid: String

  public init(deviceUuid: String) {
    self.deviceUuid = deviceUuid
  }

  public var __variables: Variables? { ["deviceUuid": deviceUuid] }

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.SubscriptionRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("scanLogin", ScanLogin.self, arguments: ["deviceUuid": .variable("deviceUuid")]),
    ] }

    public var scanLogin: ScanLogin { __data["scanLogin"] }

    /// ScanLogin
    ///
    /// Parent Type: `AppEvent`
    public struct ScanLogin: Ichatgl.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Unions.AppEvent }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .inlineFragment(AsQrcodeScanned.self),
        .inlineFragment(AsQrcodeConfirmed.self),
        .inlineFragment(AsQrcodeCancel.self),
      ] }

      public var asQrcodeScanned: AsQrcodeScanned? { _asInlineFragment() }
      public var asQrcodeConfirmed: AsQrcodeConfirmed? { _asInlineFragment() }
      public var asQrcodeCancel: AsQrcodeCancel? { _asInlineFragment() }

      /// ScanLogin.AsQrcodeScanned
      ///
      /// Parent Type: `QrcodeScanned`
      public struct AsQrcodeScanned: Ichatgl.InlineFragment {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public typealias RootEntityType = SubscriptionScanLoginSubscription.Data.ScanLogin
        public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.QrcodeScanned }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("deviceUuid", String.self),
        ] }

        public var deviceUuid: String { __data["deviceUuid"] }
      }

      /// ScanLogin.AsQrcodeConfirmed
      ///
      /// Parent Type: `QrcodeConfirmed`
      public struct AsQrcodeConfirmed: Ichatgl.InlineFragment {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public typealias RootEntityType = SubscriptionScanLoginSubscription.Data.ScanLogin
        public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.QrcodeConfirmed }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("token", String.self),
          .field("deviceUuid", String.self),
        ] }

        public var token: String { __data["token"] }
        public var deviceUuid: String { __data["deviceUuid"] }
      }

      /// ScanLogin.AsQrcodeCancel
      ///
      /// Parent Type: `QrcodeCancel`
      public struct AsQrcodeCancel: Ichatgl.InlineFragment {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public typealias RootEntityType = SubscriptionScanLoginSubscription.Data.ScanLogin
        public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.QrcodeCancel }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("deviceUuid", String.self),
        ] }

        public var deviceUuid: String { __data["deviceUuid"] }
      }
    }
  }
}
