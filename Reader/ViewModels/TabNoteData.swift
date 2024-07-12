//
//  TabNoteData.swift
//  Reader
//
//  Created by V™️ on 2024/7/12.
//

import SwiftUI

struct Note: Codable, Identifiable {
    var id: UUID
    var title: String
    var content: String
    var imageURLAppendix: String?
}

class TabNoteData: ObservableObject {
    // @Published 包装器标注为发布器
    @Published var notes: [Note] = []

    // 意思是让 FileManager 在用户可存取的空间中 userDomainMask，查找负责存储文件 documentDirectory 的默认沙盒地址
    static let sandboxURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let notesURL = sandboxURL.appendingPathComponent("notes.json")
    /**
        当应用每次启动时，应该自动读取本地文件并显示出来
     */
    init() {
        notes = getNotes()
    }

    /**
        负责读取本地的 JSON 文件，并返回 [notes] 数组
     */
    func getNotes() -> [Note] {
        var result: [Note] = []
        if FileManager.default.fileExists(atPath: notesURL.path) {
            let data = try! Data(contentsOf: notesURL)
            result = try! JSONDecoder().decode([Note].self, from: data)
        }
        return result
    }

    /**
        负责将数据存储到本地
     */
    func saveNotes() {
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? JSONEncoder().encode(self.notes)
            try? data?.write(to: self.notesURL)
        }
    }

    func getImage(_ imageURLAppendix: String) -> UIImage {
        let url = TabNoteData.sandboxURL.appendingPathComponent(imageURLAppendix)
        let imageData = try! Data(contentsOf: url)
        return UIImage(data: imageData, scale: 1)!
    }

    func saveImage(id: UUID, data: Data) {
        DispatchQueue.global(qos: .userInitiated).async {
            let url = TabNoteData.sandboxURL.appendingPathComponent("\(id).png")
            try? data.write(to: url)
        }
    }
    
    
}
