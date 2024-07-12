//
//  ReadingNote.swift
//  Reader
//
//  Created by V™️ on 2024/7/11.
//

import SwiftUI

struct ReadingNote: View {
    @State private var presentingSafariView = false

    var body: some View {
        NavigationView {
            VStack {
                // Spacer().frame(height: 20)
                HStack {
                    Link(destination: URL(string: "https://legolas.me")!) {
                        RoundButton(text: "在 Safari 打开", image: "safari")
                    }

                    Button(action: {
                        self.presentingSafariView = true
                    }) {
                        RoundButton(text: "在本应用中打开", image: "arrow.up.forward.app")
                    }
                    .sheet(isPresented: $presentingSafariView) {
                        SafariView(url: URL(string: "https://baidu.com")!)
                    }
                }

                NoteEntryAndList()
                
                Spacer()
            }
            .navigationTitle("笔记")
        }
    }
}

#Preview {
    ReadingNote()
}
