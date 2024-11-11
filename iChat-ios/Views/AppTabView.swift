//
//  ContentView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

enum Tab: Hashable, CaseIterable {
    case Chat
    case Contracts
    case Profile
}

struct AppTabView: View {
    @EnvironmentObject private var appVM: AppViewModel
    @StateObject var chatTabVM = ChatTabViewModel()
    @State private var selectedTab = Tab.Chat

    @State var selectedId: Int?

    var side: some View {
        VStack {
            Spacer()

            Group {
                if let avatar = appVM.userInfo?.avatar {
                    WebImage(url: URL(string: avatar))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                } else {
                    Image("Avatar Default")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                }
            }
                .clipShape(RoundedRectangle(cornerRadius: 4, style: .circular))
                .onTapGesture {
                    appVM.logout()
                }

            VStack {
                Button {
                    selectedTab = .Chat
                } label: {
                    Image(systemName: "bubble")
                }

                Button {
                    selectedTab = .Contracts
                } label: {
                    Image(systemName: "person.2")
                }
            }
                .buttonStyle(.plain)

            Spacer()
            Spacer()
        }
    }

    var body: some View {
        #if os(iOS)
        TabView(selection: $selectedTab) {
            ChatsView(selectedChatId: .constant(nil))
                .environmentObject(chatTabVM)
                .tabItem {
                    Image(systemName: "bubble")
                    Text("聊天")
                }
                .tag(Tab.Chat)
            ContactsView(selectedUserId: .constant(nil))
                .environmentObject(chatTabVM)
                .tabItem {
                    Image(systemName: "person.2")
                    Text("通讯录")
                }
                .tag(Tab.Contracts)
//            VStack {
//                Text("Search Tab")
//            }
//            .tabItem {
//                Image(systemName: "party.popper")
//                Text("动态")
//            }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("我的")
                }
                .tag(Tab.Profile)
        }
        #elseif os(macOS)
        NavigationSplitView {
            side
                .navigationSplitViewColumnWidth(min: 90, ideal: 90, max: 90)
        } content: {
            if selectedTab == .Chat {
                ChatsView(selectedChatId: $selectedId)
                    .environmentObject(chatTabVM)
            } else if selectedTab == .Contracts {
                ContactsView(selectedUserId: $selectedId)
                    .environmentObject(chatTabVM)
            }
        } detail: {
            if selectedTab == .Chat {
                if let id = selectedId {
                    ChatMessagesView(id: id)
                        .id(id)
                }
            } else if selectedTab == .Contracts {
                if let id = selectedId {
                    ContactsDetailView(id: id, fullname: "1", email: "2")
                        .id(id)
                }
            }
        }
        #endif

    }
}

#Preview {
    AppTabView()
}
