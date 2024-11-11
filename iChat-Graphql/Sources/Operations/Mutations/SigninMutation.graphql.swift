// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SigninMutation: GraphQLMutation {
  public static let operationName: String = "Signin"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation Signin($req: SigninUser!) { auth: signin(input: $req) { __typename token user { __typename id fullname } } }"#
    ))

  public var req: SigninUser

  public init(req: SigninUser) {
    self.req = req
  }

  public var __variables: Variables? { ["req": req] }

  public struct Data: Ichatgl.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.MutationRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("signin", alias: "auth", Auth.self, arguments: ["input": .variable("req")]),
    ] }

    public var auth: Auth { __data["auth"] }

    /// Auth
    ///
    /// Parent Type: `AuthOutput`
    public struct Auth: Ichatgl.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { Ichatgl.Objects.AuthOutput }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("token", String.self),
        .field("user", User.self),
      ] }

      public var token: String { __data["token"] }
      public var user: User { __data["user"] }

      /// Auth.User
      ///
      /// Parent Type: `User`
      public struct User: Ichatgl.SelectionSet {
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
}
