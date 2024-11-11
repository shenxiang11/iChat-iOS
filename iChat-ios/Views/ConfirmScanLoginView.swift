//
//  ConfirmScanLoginView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/11/10.
//

import SwiftUI
import Ichatgl

struct ConfirmScanLoginView: View {
    @Binding var show: Bool
    @Binding var deviceUuid: String

    var body: some View {
        VStack(spacing: 180) {
            Spacer()
            VStack {
                Image(systemName: "macbook")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)

                Text("登录 Mac iChat")
                    .font(.title3)
            }

            Spacer()

            VStack(spacing: 20) {
                Button {
                    Network.shared.apollo.perform(mutation: ConfirmScanLoginMutation(deviceUuid: deviceUuid)) { result in
                        switch result {
                        case .success(let graphQLResult):
                            show = false
                        case .failure(let error):
                            print("Cancel scaned Error: \(error)")
                        }
                    }
                } label: {
                    Text("登录")
                        .frame(width: 120)
                }
                .buttonStyle(.borderedProminent)

                Button {
                    Network.shared.apollo.perform(mutation: CancelScanedMutation(deviceUuid: deviceUuid)) { result in
                        switch result {
                        case .success(let graphQLResult):
//                            if case true = graphQLResult.data?.cancelScanned {
//                                show = false
//                            }
                            show = false
                        case .failure(let error):
                            print("Cancel scaned Error: \(error)")
                        }
                    }
                } label: {
                    Text("取消登录")
                }
            }
        }
    }
}

#Preview {
    ConfirmScanLoginView(show: .constant(true), deviceUuid: .constant(""))
}
