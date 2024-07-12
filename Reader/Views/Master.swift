//
//  ContentView.swift
//  Reader
//
//  Created by V™️ on 2024/7/10.
//

import SwiftUI

struct Master: View {
    // 负责数据来源
    @StateObject var data = TabReadingData()
    // 负责应用设置存储
    @AppStorage("darkMode") var darkMode = false

    var body: some View {
        // NavigationView 负责视图间关系
        NavigationView {
            // List 显示将数据转化为列表
            List(data.articles) { article in
                // Detail 负责跳转后的详情
                NavigationLink(destination: Detail(article: article)) {
                    // Row 负责显示列表中每一行的内容
                    Row(article: article)
                }
            }
            .navigationTitle("编辑推荐")
            // .toolbar 负责告知系统需要边栏
            .toolbar {
                // Setting 负责设置按钮 将绑定传递下去
                Setting(darkMode: $darkMode)
            }
        }
        // .preferredColorScheme 负责控制暗色模式
        // 该代码会判断目前用户选择的 darkMode 变量的值，若为真，则切换到深色模式，反之切换到浅色模式
        // preferredColorScheme() 需要注意其作用范围，该修改器仅能作用于被修饰的视图及其子视图中
        .preferredColorScheme(darkMode ? .dark : .light)
    }
}

#Preview {
    Master()
}
