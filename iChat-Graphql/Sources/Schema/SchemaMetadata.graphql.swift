// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == Ichatgl.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == Ichatgl.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == Ichatgl.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == Ichatgl.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "QueryRoot": return Ichatgl.Objects.QueryRoot
    case "Chat": return Ichatgl.Objects.Chat
    case "User": return Ichatgl.Objects.User
    case "Message": return Ichatgl.Objects.Message
    case "MutationRoot": return Ichatgl.Objects.MutationRoot
    case "AuthOutput": return Ichatgl.Objects.AuthOutput
    case "SubscriptionRoot": return Ichatgl.Objects.SubscriptionRoot
    case "CreatedChat": return Ichatgl.Objects.CreatedChat
    case "ChatOwnerChanged": return Ichatgl.Objects.ChatOwnerChanged
    case "ChatNameChanged": return Ichatgl.Objects.ChatNameChanged
    case "ChatDeleted": return Ichatgl.Objects.ChatDeleted
    case "QrcodeScanned": return Ichatgl.Objects.QrcodeScanned
    case "QrcodeCancel": return Ichatgl.Objects.QrcodeCancel
    case "QrcodeConfirmed": return Ichatgl.Objects.QrcodeConfirmed
    case "MessageOutput": return Ichatgl.Objects.MessageOutput
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
