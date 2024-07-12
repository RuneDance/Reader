//
//  Detail.swift
//  Reader
//
//  Created by V™️ on 2024/7/11.
//

import SwiftUI

struct Detail: View {
    var article: Article

    var body: some View {
        ScrollView {
            VStack {
                Text(article.body)
            }
            .padding()
        }
        .navigationTitle(article.title)
    }
}

#Preview {
    Detail(article: Article(id: 1, title: "标题", body: "正文"))
}
