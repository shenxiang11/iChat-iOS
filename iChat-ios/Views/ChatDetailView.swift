//
//  ChatDetailView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/11/4.
//

import SwiftUI
import SDWebImageSwiftUI
import Ichatgl

struct ChatDetailView: View {
    let id: Int
    @StateObject var vm: ChatDetailViewModel

    @EnvironmentObject var chatTabVM: ChatTabViewModel

    init(id: Int) {
        self.id = id
        _vm = StateObject(wrappedValue: .init(chatId: id))
    }

    var chatNameView: some View {
        HStack {
            Text("群聊名称")
                .foregroundStyle(.black)
            Spacer()
            HStack {
                Text(vm.chat?.name ?? "")
                if case true = vm.chat?.isOwner {
                    Image(systemName: "chevron.right")
                }
            }
            .foregroundStyle(.gray)
        }
        .padding()
        .background(.white)
    }


    var body: some View {
        let item = GridItem(.adaptive(minimum: 50, maximum: 100))
        let columns = [item, item, item, item, item, item]

        ScrollView {
            VStack(spacing: 20) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(vm.chat?.members ?? [], id: \.self) { user in
                        NavigationLink(value: Routes.ContactsDetail(id: user.id, avatar: user.avatar, fullname: user.fullname, email: user.email, isSelf: user.isSelf)) {
                            VStack {
                                Group {
                                    if let avatar = user.avatar {
                                        WebImage(url: URL(string: avatar))
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(maxWidth: .infinity)
                                            .clipShape(.rect(cornerRadius: 4, style: .circular))
                                    } else {
                                        Image("Avatar Default")
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(maxWidth: .infinity)
                                            .clipShape(.rect(cornerRadius: 4, style: .circular))
                                    }
                                }
                                .overlay(alignment: .topTrailing) {
                                    if vm.chat?.ownerId == user.id && vm.chat?.type == Ichatgl.ChatType.group  {
                                        Text("群主")
                                            .font(.footnote)
                                            .foregroundStyle(.white)
                                            .padding(2)
                                            .background(.blue)
                                            .clipShape(RoundedRectangle(cornerRadius: 2, style: .circular))
                                            .offset(x: 4, y: -4)
                                    }
                                }


                                Text(user.fullname)
                                    .font(.footnote)
                                    .lineLimit(1)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.white)
            }

            if case true = vm.chat?.isOwner, vm.chat?.type == Ichatgl.ChatType.group {
                NavigationLink(value: Routes.EditChatGroupName(id: id, defaultName: vm.chat?.name ?? "")) {
                    chatNameView
                }
            } else {
                chatNameView
            }

            if case true = vm.chat?.isOwner, vm.chat?.type == Ichatgl.ChatType.group {
                Button {
                    vm.dropChat {
                        chatTabVM.path.removeLast(2)
                    }
                } label: {
                    Text("删除群聊")
                }
                .buttonStyle(.bordered)
                .foregroundStyle(.red)
            }
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.1))
            .navigationTitle("聊天详情")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .navigationBarBackButtonHidden()
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
                #endif
            }
            .onAppear {
                vm.getChat()
            }
    }
}

#Preview {
    ChatDetailView(id: 1)
}
