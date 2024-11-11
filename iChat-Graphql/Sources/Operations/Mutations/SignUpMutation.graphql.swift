// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SignUpMutation: GraphQLMutation {
  public static let operationName: String = "SignUp"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SignUp($req: CreateUser!) { signup(input: $req) { __typename id fullname } }"#
    ))

  public var req: CreateUser

  public init(req: CreateUser) {
    self.req = req
  }

  public var __variables: Variables? { ["req": req] }

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.MutationRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("signup", Signup.self, arguments: ["input": .variable("req")]),
    ] }

    public var signup: Signup { __data["signup"] }

    /// Signup
    ///
    /// Parent Type: `User`
    public struct Signup: Ichatgl.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.User }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("fullname", String.self),
      ] }

      public var id: Int { __data["id"] }
      public var fullname: String { __data["fullname"] }
    }
  }
}
