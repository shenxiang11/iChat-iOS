//
//  ChatsDetailViewModel.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/24.
//

import SwiftUI
import Apollo
import Ichatgl

class ChatMessagesViewModel: ObservableObject {
    let chatId: Int
    var cursorId: GraphQLNullable<Int> = .none

    init(chatId: Int) {
        self.chatId = chatId

//        self.subscribe()
    }

    private var subscription: Cancellable?

    @Published var messages: [GetMessagesQuery.Data.Message] = []
    @Published var chat: GetMessagesQuery.Data.Chat?

    func subscribe() {
        subscription = Network.shared.apollo.subscribe(subscription: SubscriptionMessageSubscription(chatId: chatId)) { [self] result in
            switch result {
            case .success(let graphQLResult):
                if let message = graphQLResult.data?.message {
                    self.messages.append(GetMessagesQuery.Data.Message(_dataDict: message.__data))
                }
                // in the detail page, any new messages is readed
                self.clearUnreadCount()
            case .failure(let error):
                print("Subscription Messages failed: \(error.localizedDescription)")
            }
        }
    }

    func cancelSubscription() {
        subscription?.cancel()
    }

    func fetchMessages(completion: ((_ prevCursorId: Int?) -> Void)? = nil) {
        let prevCursorId = self.cursorId.unwrapped
        Network.shared.apollo.fetch(query: GetMessagesQuery(chatId: chatId, cursorId: cursorId), cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let graphQLResult):
                self.chat = graphQLResult.data?.chat
                self.clearUnreadCount()
                if let _ = self.cursorId.unwrapped {
                    self.messages.insert(contentsOf: graphQLResult.data?.messages ?? [], at: 0)
                } else {
                    self.messages = graphQLResult.data?.messages ?? []
                }
                if self.messages.count > 0 {
                    self.cursorId = .init(integerLiteral: self.messages[0].id)
                }
                completion?(prevCursorId)
            case .failure(let error):
                print("Fetch Messages sError: \(error)")
            }
        }
    }

    func clearUnreadCount() {
        Network.shared.apollo.perform(mutation: SetReadedMutation(chatId: chatId)) { _ in
            //
        }
    }

    func sendMessage(chatId: Int, content: String) {
        Network.shared.apollo.perform(mutation: SendMessageMutation(req: CreateMessage(chatId: chatId, content: content))) { result in
            switch result {
            case .success(let graphQLResult):
                print(graphQLResult.data)
            case .failure(let error):
                print("Send Message Error: \(error)")
            }
        }
    }
}
