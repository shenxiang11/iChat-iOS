//
//  ChatDetailView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/24.
//

import SwiftUI
import Ichatgl

struct ChatMessagesView: View {
    let id: Int

    @State private var fistScrollToBottom = false
    @State private var useScrolled = false
    @State private var isLoading = true

    @StateObject var vm: ChatMessagesViewModel

    @State private var messageInput: String = ""

    @State private var position = ScrollPosition(edge: .bottom)

    init(id: Int) {
        self.id = id
        _vm = StateObject(wrappedValue: .init(chatId: id))
    }

    var more: some View {
        NavigationLink(value: Routes.ChatDetail(id: id)) {
            Image(systemName: "ellipsis")
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack {
                    ForEach(vm.messages, id: \.id) { message in
                        TimelineView(.everyMinute) {_ in
                            VStack {
                                MessageView(name: message.user.fullname, avatar: message.user.avatar, content: "\(message.content)", isCurrentUser: message.isMine, time: timeAgoSinceDate(message.createdAt), user: message.user)
                            }
                        }
                        .id(message.id)
                    }
                }
            }
            .scrollPosition($position)
            .onScrollGeometryChange(for: Double.self, of: { geo in
                geo.contentOffset.y
            }, action: { oldValue, newValue in
                if newValue < 100 && !isLoading {
                    isLoading = true
                    vm.fetchMessages { _ in
                        isLoading = false
                    }
                }
            })
            .onChange(of: vm.messages, { _, messages in
                // TODO:
                // if the message is send, scroll to last message (you sent it)
                // if never scroll by user, then always scroll to last message
                if let message = messages.last {
                    withAnimation {
                        position.scrollTo(id: message.id)
                    }
                }
            })

            HStack {
                TextField(text: $messageInput) {
                    EmptyView()
                }
                    .submitLabel(.send)
                    .onSubmit({
                        vm.sendMessage(chatId: id, content: messageInput)
                        messageInput = ""
                    })
                    .padding(8)
                    .background {
                        Rectangle()
                            .foregroundStyle(.white)
                    }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background {
                Rectangle()
                    .foregroundStyle(.gray.opacity(0.1))
                    .ignoresSafeArea()
            }
        }
        #if os(iOS)
        .toolbar(.hidden, for: .tabBar)
        #endif
        .task({
            isLoading = true
            vm.fetchMessages { prevCursor in
                if prevCursor == nil {
                    // FIXME:
                    // Cannot scroll to bottom if there is no asyncAfter
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        position.scrollTo(edge: .bottom)
                        isLoading = false
                    }
                }
            }
        })
        .onAppear {
            vm.subscribe()
        }
        .onDisappear(perform: {
            vm.cancelSubscription()
        })
        .navigationTitle((vm.chat?.type == Ichatgl.ChatType.group ? vm.chat?.name : vm.chat?.original9Users.filter({ !$0.isSelf }).first?.fullname) ?? "")
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
                more
            }
            #elseif os(macOS)
            ToolbarItem(placement: .primaryAction) {
                more
            }
            #endif
        }
    }
}

func timeAgoSinceDate(_ dateStr: String) -> String {
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ"

    if let date = dateFormatter.date(from: dateStr) {
        let now = Date()
        let components = calendar.dateComponents([.second, .minute, .hour, .day], from: date, to: now)

        if let day = components.day, day >= 1 {
            return "\(day) 天前"
        } else if let hour = components.hour, hour < 24, hour > 1 {
            return "\(hour) 小时前"
        } else if let minute = components.minute, minute < 60, minute > 1 {
            return "\(minute) 分钟前"
        } else if let second = components.second, second < 60 {
            return "刚刚"
        }

        return ""
    } else {
        return ""
    }
}

#Preview {
    ChatMessagesView(id: 1)
}
