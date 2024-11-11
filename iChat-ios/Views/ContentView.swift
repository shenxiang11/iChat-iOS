//
//  ContentView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/30.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appVM: AppViewModel

    var body: some View {
        switch appVM.page {
        case .App:
            AppTabView()
        case .Login:
            #if os(iOS)
            LoginView()
            #elseif os(macOS)
            LoginQRCodeView()
            #endif
        case .Signup:
            SignupView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppViewModel())
}
