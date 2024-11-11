//
//  Network.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/23.
//

import SwiftUI
import Apollo
import ApolloAPI
import ApolloWebSocket

class Network {
    static var shared = {
        let token = UserDefaults.standard.string(forKey: TOKEN_KEY)

        return Network(token: token ?? "")
    }()

    private(set) var apollo: ApolloClient

    private init(token: String) {
        let endpointURL = URL(string: "http://192.168.1.8:8080")!

        let ws_endpointURL = URL(string: "ws://192.168.1.8:8080/ws")!

        let store = ApolloStore()

        let interceptorProvider = NetworkInterceptorsProvider(interceptors: [
            AuthInterceptor(),
        ], store: store)

        let authPayloads = [
            "Authorization": "Bearer \(token)"
        ]

        let websocket = WebSocket(url: ws_endpointURL, protocol: .graphql_ws)

        let networkTransport = RequestChainNetworkTransport(interceptorProvider: interceptorProvider, endpointURL: endpointURL, additionalHeaders: authPayloads)

        // FIXME: ws not handle the auth problem here, user cannot receive message ensure by server side, user will be forbid by other http connect err.
        let websocketTransport = WebSocketTransport(websocket: websocket, store: store, config: WebSocketTransport.Configuration(connectingPayload: authPayloads))

        let splitNetworkTransport = SplitNetworkTransport(uploadingNetworkTransport: networkTransport, webSocketNetworkTransport: websocketTransport)

        apollo = ApolloClient(networkTransport: splitNetworkTransport, store: ApolloStore())
    }

    static func setToken(token: String) {
        Self.shared = Network(token: token)
    }

}

class NetworkInterceptorsProvider: DefaultInterceptorProvider {

    let interceptors: [ApolloInterceptor]

    init(interceptors: [ApolloInterceptor], store: ApolloStore) {
        self.interceptors = interceptors
        super.init(store: store)
    }

    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
        var interceptors = super.interceptors(for: operation)
        self.interceptors.forEach { interceptor in
            interceptors.append(interceptor)
        }
        return interceptors
    }
}

class AuthInterceptor: ApolloInterceptor {

  enum AuthError: Error {
    case notYetReceived
  }

  public var id: String = UUID().uuidString

  func interceptAsync<Operation: GraphQLOperation>(
    chain: RequestChain,
    request: HTTPRequest<Operation>,
    response: HTTPResponse<Operation>?,
    completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
  ) {
      defer {
          chain.proceedAsync(
            request: request,
            response: response,
            interceptor: self,
            completion: completion
          )
      }

      guard let receivedResponse = response else {
          chain.handleErrorAsync(
            AuthError.notYetReceived,
            request: request,
            response: response,
            completion: completion
          )
          return
      }

      if let errors = receivedResponse.parsedResponse?.errors {
          for err in errors {
              // FIXME: server should support error code in extensions
              if let message = err.message, message == "Get graphql user id error" {
                  print("Token 过期，登出")
                  AppViewModel.shared.logout()
                  break
              }
          }
      }
  }
}
