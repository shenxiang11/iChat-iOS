//
//  LoginView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/30.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject private var appVM: AppViewModel

    @State private var email = "863461783@qq.com"
    @State private var code = ""
    @State private var password = "123456"
    @State private var fullname = "香饽饽"

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text("iChat")
                    .font(.largeTitle).bold()

                Spacer()

                Button {
                    appVM.page = .Login
                } label: {
                    Text("登录")
                }
            }

            ZStack(alignment: .trailing) {
                TextField("邮箱", text: $email)
                    .textContentType(.emailAddress)
                    .beautifyTextField(iconSystemName: "envelope.open.fill")

                Button {
                    appVM.sendSignupEmail(email: email)
                } label: {
                    Text("发送验证码")
                        .padding()
                }
            }

            SecureField("验证码", text: $code)
                .textContentType(.password)
                .beautifyTextField(iconSystemName: "key")

            SecureField("密码", text: $password)
                .textContentType(.password)
                .beautifyTextField(iconSystemName: "key.fill")

            TextField("昵称", text: $fullname)
                .textContentType(.emailAddress)
                .beautifyTextField(iconSystemName: "person.circle")

            Button {
                appVM.signup(email: email, password: password, code: code, name: fullname)
            } label: {
                Text("注册")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .frame(height: 40)
            }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)

            if let err = appVM.signupError {
                Text(err.message ?? "发生错误")
                    .foregroundStyle(.red)
            }

            Spacer()
        }
        .padding()

    }
}

#Preview {
    SignupView()
        .environmentObject(AppViewModel())
}
