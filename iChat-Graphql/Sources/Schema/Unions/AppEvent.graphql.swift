// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension Unions {
  static let AppEvent = Union(
    name: "AppEvent",
    possibleTypes: [
      Objects.CreatedChat.self,
      Objects.ChatOwnerChanged.self,
      Objects.ChatNameChanged.self,
      Objects.ChatDeleted.self,
      Objects.Message.self,
      Objects.QrcodeScanned.self,
      Objects.QrcodeCancel.self,
      Objects.QrcodeConfirmed.self
    ]
  )
}