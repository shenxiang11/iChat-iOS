//
//  iChat_iosApp.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/21.
//

import SwiftUI

@main
struct iChat_iosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(AppViewModel.shared)
    }
}
