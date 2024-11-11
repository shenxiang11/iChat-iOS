//
//  LoginView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/30.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var appVM: AppViewModel

    @State private var email = "1863461789@qq.com"
    @State private var password = "123456"

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text("iChat")
                    .font(.largeTitle).bold()

                Spacer()

                Button {
                    appVM.page = .Signup
                } label: {
                    Text("注册")
                }
            }

            TextField("邮箱", text: $email)
                .textContentType(.emailAddress)
                .beautifyTextField(iconSystemName: "envelope.open.fill")

            SecureField("密码", text: $password)
                .textContentType(.password)
                .beautifyTextField(iconSystemName: "key.fill")

            Button {
                appVM.signin(email: email, password: password)
            } label: {
                Text("登录")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .frame(height: 40)
            }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)

            if let err = appVM.loginError {
                Text(err.message ?? "发生错误")
                    .foregroundStyle(.red)
            }

            Spacer()
        }
        .padding()
        .onDisappear {
            appVM.loginError = nil
        }
    }
}

struct TextFieldModifier: ViewModifier {
    var iconSystemName: String

    func body(content: Content) -> some View {
        content
            .overlay(
                HStack {
                    Image(systemName: iconSystemName)
                        .frame(width: 36, height: 36)
                        .background(.thinMaterial)
                        .cornerRadius(14)
                        .offset(x: -46)
                        .foregroundStyle(.secondary)
                        .accessibility(hidden: true)
                        .modifier(OutlineOverlay(cornerRadius: 14))
                    Spacer()
                }
            )
            .foregroundStyle(.primary)
            .padding(15)
            .padding(.leading, 40)
            .background(.thinMaterial)
            .cornerRadius(20)
    }
}

struct OutlineOverlay: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var cornerRadius: CGFloat = 20

    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(
                    .linearGradient(
                        colors: [
                            .white.opacity(colorScheme == .dark ? 0.6 : 0.3),
                            .black.opacity(colorScheme == .dark ? 0.3 : 0.1)
                        ],
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .blendMode(.overlay)
        )
    }
}

extension View {
    func beautifyTextField(iconSystemName: String) -> some View {
        self.modifier(TextFieldModifier(iconSystemName: iconSystemName))
    }
}

#Preview {
    LoginView()
        .environmentObject(AppViewModel())
}
