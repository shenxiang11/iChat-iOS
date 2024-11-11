//
//  ContactsView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/24.
//

import SwiftUI
import SDWebImageSwiftUI
import Ichatgl

struct ContactsSelectView: View {
    @EnvironmentObject var chatTabVM: ChatTabViewModel
    @State var list: [GetUsersQuery.Data.List] = []
    @State var selectedIds: Set<Int> = []

    private func cellView(user: GetUsersQuery.Data.List) -> some View {
        HStack {
            if let avatar = user.avatar {
                WebImage(url: URL(string: avatar))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .clipShape(.rect(cornerRadius: 4, style: .circular))
            } else {
                Image("Avatar Default")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .clipShape(.rect(cornerRadius: 4, style: .circular))
            }
            Text("\(user.fullname)" + "\(user.isSelf ? "(你)" : "")")
                .font(.system(size: 14))

            Spacer()
            if selectedIds.contains(user.id) {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
        .overlay {
            Button {
                if selectedIds.contains(user.id) {
                    selectedIds.remove(user.id)
                } else {
                    selectedIds.insert(user.id)
                }
            } label: {
                Rectangle()
                    .foregroundStyle(.clear)
            }

        }

    }

    var body: some View {
        List(list, id: \.id) { user in
            if !user.isSelf {
                cellView(user: user)
            }
        }
        .listStyle(.plain)
        #if os(iOS)
        .toolbar(.hidden, for: .tabBar)
        #endif
        .navigationBarBackButtonHidden()
        .toolbar {
            #if os(iOS)
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Network.shared.apollo.perform(mutation: CreateChatMutation(memberIds: Array(selectedIds))) { result in
                        switch result {
                        case .success(let graphQLResult):
                            if let chat = graphQLResult.data?.createChat {
                                chatTabVM.path.removeLast()
                                chatTabVM.path.append(Routes.ChatMessages(id: chat.id))
                            }
                        case .failure(let error):
                            print("Drop chat failed: \(error.localizedDescription)")
                        }
                    }
                } label: {
                    Text("确定")
                }
            }
            #endif
        }
        .onAppear {
            fetchUsers()
        }
    }

    private func fetchUsers() {
        Network.shared.apollo.fetch(query: GetUsersQuery()) { result in
            print("result: ", result)
            switch result {
            case .success(let graphQLResult):
                list = graphQLResult.data?.list ?? []
            case .failure(let error):
                print("Fetch Users Error: \(error)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContactsSelectView()
    }
    .environmentObject(ChatTabViewModel())
}
