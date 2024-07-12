//
//  CheckIn.swift
//  Reader
//
//  Created by V™️ on 2024/7/12.
//

import MapKit
import SwiftUI

struct CheckIn: View {
    @StateObject var locationManager = LocationManger()

    var body: some View {
        VStack {
            Map(coordinateRegion: $locationManager.region)
        }
    }
}

#Preview {
    CheckIn()
}
