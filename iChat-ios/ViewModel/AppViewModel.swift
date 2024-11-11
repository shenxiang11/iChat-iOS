//
//  AppViewModel.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/30.
//

import SwiftUI
import Apollo
import Ichatgl

enum Page {
    case Login
    case Signup
    case App
}

let TOKEN_KEY = "userToken"

class AppViewModel: ObservableObject {
    static let shared = AppViewModel()

    @Published var userToken: String? = nil {
        didSet {
            if let userToken = userToken {
                UserDefaults.standard.set(userToken, forKey: TOKEN_KEY)
            } else {
                UserDefaults.standard.removeObject(forKey: TOKEN_KEY)
            }
        }
    }

    @Published var page: Page

    @Published var loginError: GraphQLError?
    @Published var signupError: GraphQLError?

    @Published var userInfo: GetUserQuery.Data.GetSelf?

    init() {
        let userToken = UserDefaults.standard.string(forKey: TOKEN_KEY)
        self.userToken = userToken
        self.page = userToken != nil ? Page.App : Page.Login
    }

    func logout() {
        userToken = nil
        self.page = Page.Login
    }

    func signin(email: String, password: String) {
        Network.shared.apollo.perform(mutation: SigninMutation(req: SigninUser(email: email, password: password))) { result in
            switch result {
            case .success(let graphqlResult):
                if let err = graphqlResult.errors?.first {
                    self.loginError = err
                } else if let token = graphqlResult.data?.auth.token {
                    self.userToken = token
                    Network.setToken(token: token)
                    self.page = .App
                }
            case .failure(let error):
                print("Login failed: \(error.localizedDescription)")
            }
        }
    }

    func signup(email: String, password: String, code: String, name: String) {
        Network.shared.apollo.perform(mutation: SignUpMutation(req: CreateUser(email: email, code: code, password: password, fullname: name))) { result in
            switch result {
            case .success(let graphqlResult):
                if let err = graphqlResult.errors?.first {
                    self.signupError = err
                } else {
                    self.page = .Login
                }
            case .failure(let error):
                print("Signup failed: \(error.localizedDescription)")
            }
        }
    }

    func sendSignupEmail(email: String) {
        Network.shared.apollo.perform(mutation: SendEmailMutation(req: SendEmail(email: email))) { result in
            switch result {
            case .success(let graphqlResult):
                if let err = graphqlResult.errors?.first {
                    self.signupError = err
                }
            case .failure(let error):
                print("Signup failed: \(error.localizedDescription)")
            }
        }
    }

    func getSelf() {
        Network.shared.apollo.fetch(query: GetUserQuery(), cachePolicy: .returnCacheDataAndFetch) { result in
            switch result {
            case .success(let graphqlResult):
                if let user = graphqlResult.data?.getSelf {
                    self.userInfo = user
                }
            case .failure(let error):
                print("getSelf failed: \(error.localizedDescription)")
            }
        }
    }
}
