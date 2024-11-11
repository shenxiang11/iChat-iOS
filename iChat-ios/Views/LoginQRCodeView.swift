//
//  LoginQRCodeView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/11/8.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct LoginQRCodeView: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    @StateObject var vm: LoginQRCodeViewModel = LoginQRCodeViewModel()

    var body: some View {
        VStack {
            Text("扫码登录 iChat")
                .font(.title2)

            Group {
                if let qrCodeImage = generateQRCode(from: vm.deviceUuid) {
                    Image(qrCodeImage, scale: 1, label: Text(""))
                        .interpolation(.none)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .blur(radius: vm.status == .Scanned ? 5 : 0)
                } else {
                    Text("Error.")
                }
            }
            .overlay {
                if vm.status == .Scanned {
                    Rectangle()
                        .fill(.ultraThinMaterial.opacity(0.8))
                        .overlay {
                            VStack {
                                Text("请在手机上确认")

                                Button {
                                    vm.cancelSubscribe()
                                    vm.subscribe()
                                    vm.status = .Displaying
                                } label: {
                                    Text("取消")
                                }

                            }
                        }
                }
            }
        }
            .padding()
            .onAppear {
                vm.subscribe()
            }
            .onDisappear {
                vm.cancelSubscribe()
            }
    }

    func generateQRCode(from string: String) -> CGImage? {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            return context.createCGImage(outputImage, from: outputImage.extent)
        }

        return nil
    }
}

#Preview {
    LoginQRCodeView()
        .environmentObject(ChatTabViewModel())
}
