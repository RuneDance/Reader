//
//  Setting.swift
//  Reader
//
//  Created by V™️ on 2024/7/11.
//

import SwiftUI

struct Setting: View {
    @Binding var darkMode: Bool

    var body: some View {
        Button(action: {
            // 让该按钮支持震动反馈
            Vibration.selection.vibrate()
            darkMode.toggle()
        }) {
            // 想让月亮图标采用加粗圆角的方案显示，只需改变其字体即可
            Image(systemName: darkMode ? "sun.max.fill" : "moon.fill").font(.system(.headline, design: .rounded))
        }
    }
}

#Preview {
    Setting(darkMode: .constant(false))
}
