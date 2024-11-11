//
//  ChatDetailViewModel.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/11/4.
//

import Foundation
import Ichatgl

class ChatDetailViewModel: ObservableObject {
    let chatId: Int
    @Published var chat: GetChatQuery.Data.GetChat?

    init(chatId: Int) {
        self.chatId = chatId
    }

    func getChat() {
        Network.shared.apollo.fetch(query: GetChatQuery(id: chatId), cachePolicy: .returnCacheDataAndFetch) { result in
            switch result {
            case .success(let graphQLResult):
                self.chat = graphQLResult.data?.getChat
            case .failure(let error):
                print("Get chat failed: \(error.localizedDescription)")
            }
        }
    }

    func dropChat(completion: (() -> Void)?) {
        Network.shared.apollo.perform(mutation: DropChatMutation(id: chatId), publishResultToStore: true) { result in
            switch result {
            case .success(let graphQLResult):
                if case true = graphQLResult.data?.dropChat {
                    completion?()
                }
            case .failure(let error):
                print("Drop chat failed: \(error.localizedDescription)")
            }
        }
    }
}
