//
//  GridAvatar.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct GridAvatar: View {
    let items: [String?] // 数据源

    // 计算列数（3x3 为上限）
    private var columns: Int {
        min(3, Int(ceil(Double(items.count).squareRoot())))
    }

    var body: some View {
        Grid(horizontalSpacing: 1, verticalSpacing: 1) {
            ForEach(0..<rows(), id: \.self) { row in
                GridRow {
                    ForEach(0..<columns, id: \.self) { col in
                        let index = row * columns + col
                        if index < items.count {
                            if let url = items[index] {
                                WebImage(url: URL(string: url)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .clipShape(.rect(cornerRadius: 2, style: .circular))
                                } placeholder: {
                                    Rectangle()
                                        .foregroundStyle(.clear)
                                        .clipShape(.rect(cornerRadius: 2, style: .circular))
                                }
                            } else {
                                Image("Avatar Default")
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .clipShape(.rect(cornerRadius: 2, style: .circular))
                            }

                        } else {
                            Spacer()// 占位符
                        }
                    }
                }
            }
       }
        .frame(width: 64, height: 64)
        .padding(1)
        .background {
            Color.gray.opacity(0.3)
        }
        .clipShape(.rect(cornerRadius: 4, style: .circular))
    }

    // 计算需要的行数
    private func rows() -> Int {
        (items.count + columns - 1) / columns // 向上取整
    }
}

#Preview {
    ScrollView {
        GridAvatar(items: [nil, "https://sns-avatar-qc.xhscdn.com/avatar/63e11a78955ccf02b20dc7f5.jpg?imageView2/2/w/540/format/webp|imageMogr2/strip2", "https://sns-avatar-qc.xhscdn.com/avatar/63e11a78955ccf02b20dc7f5.jpg?imageView2/2/w/540/format/webp|imageMogr2/strip2", "https://sns-avatar-qc.xhscdn.com/avatar/63e11a78955ccf02b20dc7f5.jpg?imageView2/2/w/540/format/webp|imageMogr2/strip2", "https://sns-avatar-qc.xhscdn.com/avatar/63e11a78955ccf02b20dc7f5.jpg?imageView2/2/w/540/format/webp|imageMogr2/strip2", "https://sns-avatar-qc.xhscdn.com/avatar/63e11a78955ccf02b20dc7f5.jpg?imageView2/2/w/540/format/webp|imageMogr2/strip2", "https://sns-avatar-qc.xhscdn.com/avatar/63e11a78955ccf02b20dc7f5.jpg?imageView2/2/w/540/format/webp|imageMogr2/strip2", "https://sns-avatar-qc.xhscdn.com/avatar/63e11a78955ccf02b20dc7f5.jpg?imageView2/2/w/540/format/webp|imageMogr2/strip2", "https://sns-avatar-qc.xhscdn.com/avatar/63e11a78955ccf02b20dc7f5.jpg?imageView2/2/w/540/format/webp|imageMogr2/strip2"])



        GridAvatar(items: ["https://sns-avatar-qc.xhscdn.com/avatar/63e11a78955ccf02b20dc7f5.jpg?imageView2/2/w/540/format/webp|imageMogr2/strip2", "https://sns-avatar-qc.xhscdn.com/avatar/63e11a78955ccf02b20dc7f5.jpg?imageView2/2/w/540/format/webp|imageMogr2/strip2", "https://sns-avatar-qc.xhscdn.com/avatar/63e11a78955ccf02b20dc7f5.jpg?imageView2/2/w/540/format/webp|imageMogr2/strip2", "https://sns-avatar-qc.xhscdn.com/avatar/63e11a78955ccf02b20dc7f5.jpg?imageView2/2/w/540/format/webp|imageMogr2/strip2"])
    }
}
