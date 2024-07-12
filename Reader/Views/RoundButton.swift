//
//  RoundButton.swift
//  Reader
//
//  Created by V™️ on 2024/7/11.
//

import SwiftUI

struct RoundButton: View {
    
    let text: String
    let image: String
    
    var body: some View {
        HStack{
            Text(text)
            Image(systemName: image)
        }
        .font(.headline)
        .padding(.horizontal,10)
        .padding(.vertical,5)
        .foregroundColor(.white)
        .background(Color.accentColor)
        .cornerRadius(10)
        .shadow(radius: 3)
        
        
    }
}

#Preview {
    RoundButton(text: "目的地", image: "circle")
}
