// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct CreateMessage: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    chatId: Int,
    content: String
  ) {
    __data = InputDict([
      "chatId": chatId,
      "content": content
    ])
  }

  public var chatId: Int {
    get { __data["chatId"] }
    set { __data["chatId"] = newValue }
  }

  public var content: String {
    get { __data["content"] }
    set { __data["content"] = newValue }
  }
}
