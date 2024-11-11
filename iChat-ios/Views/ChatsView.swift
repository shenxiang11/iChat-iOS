//
//  ChatsView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/24.
//

import SwiftUI
import Ichatgl

struct ChatsView: View {
    @EnvironmentObject var chatTabVM: ChatTabViewModel
    @StateObject private var vm = ChatsViewModel()

    @Binding var selectedChatId: Int?

    var chatListView: some View {
        List(vm.chats, id: \.id, selection: $selectedChatId) { chat in
            NavigationLink(value: Routes.ChatMessages(id: chat.id)) {
                HStack {
                    ZStack(alignment: .topTrailing) {
                        if chat.type == Ichatgl.ChatType.group {
                            GridAvatar(items: chat.original9Users.map({ item in
                                item.avatar
                            }))
                        } else {
                            GridAvatar(items: chat.original9Users.filter({ user in
                                !user.isSelf
                            }).map({ item in
                                item.avatar
                            }))
                        }

                        if chat.unreadCount > 0 {
                            Text(chat.unreadCount > 99 ? "99+" : "\(chat.unreadCount)")
                                .font(.caption)
                                .fontWeight(.bold)
                                .frame(width: 16, height: 16)
                                .padding(4)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .offset(x: 10, y: -10)
                                .minimumScaleFactor(0.6)
                        }
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(chat.displayName)")
                            .font(.title3)
                            .foregroundStyle(.black)
                            .lineLimit(1)
                        Text("\(chat.latestMessage?.content ?? "")")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .lineLimit(1)
                    }

                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(.plain)
            .listRowBackground(Color.white)
            .background(chat.id == selectedChatId ? Color.gray.opacity(0.2) : Color.clear)
        }
            #if os(iOS)
            .appNavigationDestination()
            #endif
            .listStyle(.plain)
            .navigationTitle("iChat")
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button {
                            chatTabVM.path.append(Routes.ContactsSelectView(selectedIds: []))
                        } label: {
                            Label("发起群聊", systemImage: "message.fill")
                        }

                        Button {
                            chatTabVM.path.append(Routes.ScanView)
                        } label: {
                            Label("扫一扫", systemImage: "camera.viewfinder")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }

                }
                #endif
            }
            .task {
                vm.fetchChats()
            }
            .onAppear {
                vm.subscribe()
            }
            .onDisappear {
                vm.cancelSubscribe()
            }
    }

    var body: some View {
        #if os(iOS)
        NavigationStack(path: $chatTabVM.path) {
            chatListView
        }
        #elseif os(macOS)
        chatListView
        #endif
    }

}

#Preview {
    ChatsView(selectedChatId: .constant(1))
        .environmentObject(ChatTabViewModel())
}
