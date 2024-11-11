//
//  LoginQRCodeViewModel.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/11/10.
//

import SwiftUI
import Apollo
import Ichatgl

enum LoginQRCodeStatus {
    case Displaying
    case Scanned
    case Confirmed
}

class LoginQRCodeViewModel: ObservableObject {
    private var sub: Cancellable?

    @Published var chats: [GetChatsQuery.Data.List] = []
    @Published var deviceUuid = ""
    @Published var status = LoginQRCodeStatus.Displaying

    func cancelSubscribe() {
        sub?.cancel()
    }

    func subscribe() {
        deviceUuid = UUID().uuidString
        sub = Network.shared.apollo.subscribe(subscription: SubscriptionScanLoginSubscription(deviceUuid: self.deviceUuid)) { result in
            switch result {
            case .success(let graphQLResult):
                if let _ = graphQLResult.data?.scanLogin.asQrcodeScanned {
                    print("1")
                    self.status = .Scanned
                } else if let confirmed = graphQLResult.data?.scanLogin.asQrcodeConfirmed {
                    print("2")
                    self.status = .Confirmed
                    Network.setToken(token: confirmed.token)
                    AppViewModel.shared.page = .App
                } else if let _ = graphQLResult.data?.scanLogin.asQrcodeCancel {
                    print("3")
                    self.status = .Displaying
                    self.cancelSubscribe()
                    self.subscribe()
                }
            case .failure(let error):
                print("Subscription login failed: \(error)")
            }
        }
    }
}
