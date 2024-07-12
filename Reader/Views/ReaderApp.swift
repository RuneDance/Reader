//
//  ReaderApp.swift
//  Reader
//
//  Created by V™️ on 2024/7/10.
//

import LocalAuthentication
import SwiftUI

@main
struct ReaderApp: App {
    // 用于创建一个 MotionManager() Instance 实体
    let motionManager = MotionManager()
    
    // 用于存储识别验证结果
    @State var locked =  true
    
    var body: some Scene {
        WindowGroup {
            Group {
                if locked {
                    Locked(authorize: authorize)
                } else {
                    TabView {
                        // .environmentObject(motionManager) 用于把这个信息传递给应用的其他视图使用
                        Master().environmentObject(motionManager)
                            .tabItem {
                                Label("阅读列表", systemImage: "books.vertical")
                            }
                        ReadingNote().tabItem {
                            Label("笔记", systemImage: "note.text")
                        }
                        CheckIn().tabItem {
                            Label("签到", systemImage: "mappin.and.ellipse")
                        }
                    }
                }
            }
            // .onAppear() 的用途是，当被修饰的视图被显示出来，则触发修改器中包含的代码
            .onAppear { authorize() }
        }
    }
    
    func authorize() {
        let context = LAContext()
        
        // NSError和Error 此区别主要是为了让 LocalAuthentication 与老代码兼容，此处只需当作特例记住即可
        var error: NSError?
        
        // canEvaluatePolicy 是中介 context 所包含的一个函数，用途是判断设备是否支持 Face ID 或 Touch ID，如果支持，再继续进行识别
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "解锁应用") { result, _ in
                if result {
                    locked = false
                }
            }
        }
    }
}
