//
//  EditChatGroupNameView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/11/6.
//

import SwiftUI
import Ichatgl

struct EditChatGroupNameView: View {
    let id: Int
    @Environment(\.dismiss) private var dismiss
    @State var groupName: String = ""

    var body: some View {
        ScrollView {
            HStack {
                TextField(text: $groupName) {
                    Text("")
                }
                    .padding(8)
                    .background(Color.gray.opacity(0.6))
                    .cornerRadius(8)

                if !groupName.isEmpty {
                    Button(action: {
                        groupName = "" // 清空输入框内容
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("修改群聊名称")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .navigationBarBackButtonHidden()
        .toolbar {
            #if os(iOS)
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Network.shared.apollo.perform(mutation: UpdateChatNameMutation(id: id, name: groupName)) { result in
                        switch result {
                        case .success(let graphQLResult):
                            if case true = graphQLResult.data?.updateChatName {
                                dismiss()
                            }
                        case .failure(let error):
                            print("Updaet chat name failed: \(error.localizedDescription)")
                        }
                    }
                } label: {
                    Text("保存")
                }
            }
            #endif
        }
    }
}

#Preview {
    NavigationStack {
        EditChatGroupNameView(id: 1)
    }
}
