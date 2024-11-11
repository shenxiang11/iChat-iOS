//
//  ContactsView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/24.
//

import SwiftUI
import SDWebImageSwiftUI
import Ichatgl

struct ContactsView: View {
    @EnvironmentObject var chatTabVM: ChatTabViewModel
    @State var list: [GetUsersQuery.Data.List] = []

    @Binding var selectedUserId: Int?

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
        }
    }

    var listView: some View {
        List(list, id: \.id, selection: $selectedUserId) { user in
            if !user.isSelf {
                NavigationLink(value: Routes.ContactsDetail(id: user.id, avatar: user.avatar, fullname: user.fullname, email: user.email, isSelf: false)) {
                    cellView(user: user)
                }
            }
        }
        .listStyle(.plain)
        .onAppear {
            fetchUsers()
        }
        .navigationTitle("通讯录")
        .appNavigationDestination()
    }

    var body: some View {
        #if os(iOS)
        NavigationStack(path: $chatTabVM.path) {
            listView
        }
        #elseif os(macOS)
        listView
        #endif
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
        ContactsView(selectedUserId: .constant(1))
    }
    .environmentObject(ChatTabViewModel())
}
