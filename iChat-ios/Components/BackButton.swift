//
//  BackButton.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/11/6.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.backward")

        }
    }
}

#Preview {
    BackButton()
}
