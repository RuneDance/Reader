//
//  MotionManager.swift
//  Reader
//
//  Created by V™️ on 2024/7/11.
//

import CoreMotion
import SwiftUI

class MotionManager: ObservableObject {
    let motionManager = CMMotionManager()
    
    @Published var x: CGFloat = 0
    @Published var y: CGFloat = 0
    @Published var z: CGFloat = 0
    
    init() {
        // 让中介开始检测设备的传感器信息，并将所得信息放置在 data 中，以便后续处理
        motionManager.startDeviceMotionUpdates(to: .main) { data, _ in
            // 此处 guard 语法的意思是如果有信息，就把该信息赋值给 tilt，并进行后续 x、y、z 的赋值；
            // 如果没有，则停止赋值，让 x、y、z 保持在默认的 0 数值。
            guard let tilt = data?.gravity else { return }
            
            self.x = CGFloat(tilt.x)
            self.y = CGFloat(tilt.y)
            self.z = CGFloat(tilt.z)
        }
    }
}
