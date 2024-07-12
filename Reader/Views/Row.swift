//
//  Row.swift
//  Reader
//
//  Created by V™️ on 2024/7/10.
//

import SwiftUI

struct Row: View {
    var article: Article

    // 接收 ReaderApp 文件传递下来的传感器信息
    @EnvironmentObject var motion: MotionManager

    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title).font(/*@START_MENU_TOKEN@*/ .title/*@END_MENU_TOKEN@*/).bold().padding(.bottom, 3)
                .scaleEffect(max(1, 0.7 + -motion.y * 0.45))

            Text(article.body).lineLimit(3)
                .scaleEffect(max(1, 0.7 + -motion.y * 0.37))
        }.padding(.vertical)
    }
}

#Preview {
    Row(article: Article(id: 1, title: "标题", body: "正文"))
}
