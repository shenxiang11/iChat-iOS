//
//  ContactsDetailView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/11/4.
//

import SwiftUI
import SDWebImageSwiftUI
import Ichatgl

struct ContactsDetailView: View {
    @EnvironmentObject var chatTabVM: ChatTabViewModel
    
    var id: Int
    var avatar: String?
    var fullname: String
    var email: String
    var isSelf = false

    var body: some View {
        ScrollView {
            HStack(spacing: 20) {
                if let avatar = avatar {
                    WebImage(url: URL(string: avatar))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .clipShape(.rect(cornerRadius: 10, style: .circular))
                } else {
                    Image("Avatar Default")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .clipShape(.rect(cornerRadius: 10, style: .circular))
                }


                VStack(alignment: .leading) {
                    Text(fullname)
                        .font(.title3)

                    Spacer()

                    Text("Email: \(email)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .frame(height: 60)

                Spacer()
            }
            .padding()

            if !isSelf {
                Button {
                    Network.shared.apollo.perform(mutation: CreateChatMutation(memberIds: [id])) { result in
                        switch result {
                        case .success(let graphQLResult):
                            if let chat = graphQLResult.data?.createChat {
                                chatTabVM.path.append(Routes.ChatMessages(id: chat.id))
                            }
                        case .failure(let error):
                            print("Drop chat failed: \(error.localizedDescription)")
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "message")
                        Text("发送消息")
                    }
                }
                .buttonStyle(.borderedProminent)
            }

        }
            .navigationBarBackButtonHidden()
            #if os(iOS)
            .toolbar(.hidden, for: .tabBar)
            #endif
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
                #endif
            }
    }
}

#Preview {
//    ContactsDetailView(user: GetUsersQuery.Data.List.init(_dataDict: ))
}
