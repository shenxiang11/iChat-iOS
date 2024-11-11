//
//  AppNavigationDestination.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/11/7.
//

import SwiftUI

extension View {
    func appNavigationDestination() -> some View {
        self
            .navigationDestination(for: Routes.self, destination: { route in
                switch route {
                case .ChatDetail(let id):
                    ChatDetailView(id: id)
                case .ChatMessages(let id):
                    ChatMessagesView(id: id)
                case .EditChatGroupName(let id, let defaultName):
                    EditChatGroupNameView(id: id, groupName: defaultName)
                case .ContactsDetail(let id, let avatar, let fullname, let email, let isSelf):
                    ContactsDetailView(id: id, avatar: avatar, fullname: fullname, email: email, isSelf: isSelf)
                case .ContactsSelectView(let selectedIds):
                    ContactsSelectView(selectedIds: selectedIds)
                case .ScanView:
                    #if os(iOS)
                    ScanView()
                    #endif
                }
            })
    }
}
