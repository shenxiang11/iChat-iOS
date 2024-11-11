// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SendEmailMutation: GraphQLMutation {
  public static let operationName: String = "SendEmail"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SendEmail($req: SendEmail!) { result: sendEmail(input: $req) { __typename message } }"#
    ))

  public var req: SendEmail

  public init(req: SendEmail) {
    self.req = req
  }

  public var __variables: Variables? { ["req": req] }

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.MutationRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("sendEmail", alias: "result", Result.self, arguments: ["input": .variable("req")]),
    ] }

    public var result: Result { __data["result"] }

    /// Result
    ///
    /// Parent Type: `MessageOutput`
    public struct Result: Ichatgl.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.MessageOutput }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("message", String.self),
      ] }

      public var message: String { __data["message"] }
    }
  }
}
