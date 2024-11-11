// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct CreateUser: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    email: String,
    code: String,
    password: String,
    fullname: String
  ) {
    __data = InputDict([
      "email": email,
      "code": code,
      "password": password,
      "fullname": fullname
    ])
  }

  public var email: String {
    get { __data["email"] }
    set { __data["email"] = newValue }
  }

  public var code: String {
    get { __data["code"] }
    set { __data["code"] = newValue }
  }

  public var password: String {
    get { __data["password"] }
    set { __data["password"] = newValue }
  }

  public var fullname: String {
    get { __data["fullname"] }
    set { __data["fullname"] = newValue }
  }
}
