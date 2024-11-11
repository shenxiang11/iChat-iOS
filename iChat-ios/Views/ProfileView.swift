//
//  ProfileView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/30.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    @EnvironmentObject private var appVM: AppViewModel

    var userInfo: some View {
        HStack(spacing: 20) {
            if let avatar = appVM.userInfo?.avatar {
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
                Text(appVM.userInfo?.fullname ?? "用户 \(appVM.userInfo?.id ?? -1)")
                    .font(.title3)

                Spacer()

                Text("Email: \(appVM.userInfo?.email ?? "")")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .frame(height: 60)

            Spacer()

//            Image(systemName: "chevron.right")
//                .foregroundColor(.gray)
        }
        .padding()
        .onAppear {
            appVM.getSelf()
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    userInfo
//                        .overlay {
//                            NavigationLink {
//                                Text("123")
//                            } label: {
//                                Color.clear
//                            }
//                        }

                    Button {
                        appVM.page = .Login
                    } label: {
                        Text("退出登录")
                    }
                    .buttonStyle(.bordered)

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppViewModel())
}
