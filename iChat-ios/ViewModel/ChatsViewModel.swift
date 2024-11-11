//
//  ChatsViewModel.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/24.
//

import SwiftUI
import Apollo
import Ichatgl

class ChatsViewModel: ObservableObject {
    private var subscriptionChat: Cancellable?
    private var subscriptionMessage: Cancellable?

    @Published var chats: [GetChatsQuery.Data.List] = []

    init() {
//        self.subscribe()
    }

    func cancelSubscribe() {
        subscriptionChat?.cancel()
        subscriptionMessage?.cancel()
    }

    func subscribe() {
        subscriptionChat = Network.shared.apollo.subscribe(subscription: SubscriptionChatSubscription()) { result in
            switch result {
            case .success(let graphQLResult):
                if let _ = graphQLResult.data?.chat {
                    self.fetchChats(cachePolicy: .fetchIgnoringCacheData)
                }
            case .failure(let error):
                print("Subscription Chat failed: \(error)")
            }
        }

        subscriptionMessage = Network.shared.apollo.subscribe(subscription: SubscriptionAnyMessageSubscription()) { [self] result in
            switch result {
            case .success(let graphQLResult):
                if let _ = graphQLResult.data?.allMessages {
                    self.fetchChats(cachePolicy: .fetchIgnoringCacheData)
                }
            case .failure(let error):
                print("Subscription Message failed: \(error)")
            }
        }
    }

    func fetchChats(cachePolicy: CachePolicy = .returnCacheDataAndFetch) {
        Network.shared.apollo.fetch(query: GetChatsQuery(), cachePolicy: cachePolicy) { result in
            switch result {
            case .success(let graphQLResult):
                self.chats = graphQLResult.data?.list ?? []
            case .failure(let error):
                print("Fetch Chats Error: \(error)")
            }
        }
    }
}
