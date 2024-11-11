//
//  MessageCell.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/24.
//

import SwiftUI

struct MessageCell: View {
    var contentMessage: String
    var isCurrentUser: Bool

    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(isCurrentUser ? Color.white : Color.black)
            .background(isCurrentUser ? Color.blue : Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
}

#Preview {
    MessageCell(contentMessage: "This is a single message cell.", isCurrentUser: false)
}
