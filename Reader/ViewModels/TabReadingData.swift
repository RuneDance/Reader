//
//  TabReadingData.swift
//  Reader
//
//  Created by V™️ on 2024/7/10.
//

import SwiftUI

struct Article: Codable, Identifiable {
    var id: Int
    var title: String
    var body: String
}

class TabReadingData: ObservableObject {
    @Published var articles = [Article]()

    init() {
        let url = URL(string: "https://www.legolas.me/s/articles.json")!

        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                self.articles = try! JSONDecoder().decode([Article].self, from: data!)
            }
        }.resume()
    }
}
