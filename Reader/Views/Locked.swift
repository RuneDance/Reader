//
//  Locked.swift
//  Reader
//
//  Created by V™️ on 2024/7/11.
//

import SwiftUI

struct Locked: View {
    let authorize: () -> ()

    var body: some View {
        VStack {
            Image(systemName: "lock.shield")
                .font(.system(.largeTitle, design: .rounded))
                .padding(.bottom, 50)
            Button(action: {
                authorize()
                // 让该按钮支持震动反馈
                Vibration.light.vibrate()
            }) {
                Text("轻点再次尝试解锁").bold()
            }
        }
    }
}
