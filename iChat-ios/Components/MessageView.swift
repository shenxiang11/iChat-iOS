//
//  MessageView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/24.
//

import SwiftUI
import SDWebImageSwiftUI
import Ichatgl

struct MessageView : View {
    var name: String
    var avatar: String?
    var content: String
    var isCurrentUser: Bool
    var time: String = "刚刚"
    var user: GetMessagesQuery.Data.Message.User?

    var userView: some View {
        NavigationLink(value: Routes.ContactsDetail(id: user?.id ?? 1, avatar: avatar, fullname: name, email: user?.email ?? "", isSelf: isCurrentUser)) {
            VStack {
                if let avatar = avatar {
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


                Text(name)
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: 40)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)

            }
        }
        .buttonStyle(.plain)
    }

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            if !isCurrentUser {
                userView
            } else {
                Spacer()
            }

            VStack(alignment: .trailing) {
                MessageCell(contentMessage: content,
                            isCurrentUser: isCurrentUser)

                Text(time)
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }


            if isCurrentUser {
                userView
            } else {
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}


#Preview {
    MessageView(name: "kk", avatar: "https://sns-avatar-qc.xhscdn.com/avatar/1040g2jo316gmnf6oio0g5ova6n99i3pguqqq9a0?imageView2/2/w/540/format/webp|imageMogr2/strip2", content: "This is a single message cell.", isCurrentUser: true)

    MessageView(name: "yy", avatar: "https://sns-avatar-qc.xhscdn.com/avatar/1040g2jo316gmnf6oio0g5ova6n99i3pguqqq9a0?imageView2/2/w/540/format/webp|imageMogr2/strip2", content: "This is a single message cell.", isCurrentUser: false)

    MessageView(name: "TT", avatar: "https://sns-avatar-qc.xhscdn.com/avatar/1040g2jo316gmnf6oio0g5ova6n99i3pguqqq9a0?imageView2/2/w/540/format/webp|imageMogr2/strip2", content: "The average distance from the Moon to the Earth is about 238,855 miles (384,400 kilometers). This distance can vary slightly because the Moon follows an elliptical orbit around the Earth, but the figure I mentioned is the average distance.", isCurrentUser: false)
}
