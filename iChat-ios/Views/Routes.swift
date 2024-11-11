//
//  routes.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/11/6.
//

import Foundation

enum Routes: Identifiable, Codable, Hashable {

    case ChatDetail(id: Int)
    case ChatMessages(id: Int)
    case EditChatGroupName(id: Int, defaultName: String)
    case ContactsDetail(id: Int, avatar: String?, fullname: String, email: String, isSelf: Bool)
    case ContactsSelectView(selectedIds: Set<Int>)
    case ScanView

    var id: UUID {
        UUID()
    }
}
