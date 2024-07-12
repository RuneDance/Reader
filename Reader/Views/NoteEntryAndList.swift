//
//  NoteEntryAndList.swift
//  Reader
//
//  Created by V™️ on 2024/7/12.
//

import SwiftUI

import ImagePickerView

struct NoteEntryAndList: View {
    @StateObject var noteData = TabNoteData()
    @State var titleInput = ""
    @State var contentInput = ""
    @State var image: UIImage?
    @State var showImagePicker: Bool = false

    var body: some View {
        VStack {
            // 存储新笔记
            VStack {
                HStack {
                    if image != nil {
                        Image(uiImage: image!)
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/ .fill/*@END_MENU_TOKEN@*/)
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                            .cornerRadius(100)
                    }
                    VStack {
                        TextField("标题", text: $titleInput).textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("正文", text: $contentInput).textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }

                HStack {
                    Button(action: {
                        showImagePicker.toggle()
                    }) {
                        RoundButton(text: "图片", image: "photo")
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePickerView(sourceType: .photoLibrary) { image in
                            self.image = image
                        }
                    }
                    Spacer()
                    Button(action: {
                        save()
                    }) {
                        RoundButton(text: "存储笔记", image: "note.text.badge.plus")
                    }
                }
            }
            .padding()
            .background(Color(.sRGB, white: 0.9, opacity: 0.2))
            .cornerRadius(10)
            .shadow(radius: 1)
            .padding()

            // 读取现有笔记

            List {
                ForEach(noteData.notes) { note in
                    HStack {
                        if note.imageURLAppendix != nil {
                            Image(uiImage: noteData.getImage(note.imageURLAppendix!))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .cornerRadius(100)
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text(note.title).font(.title3).bold()
                            Text(note.content)
                        }
                    }

                }.onDelete(perform: delete)
            }
            // listStyle() 的修改器的作用是修改列表的显示方案
            .listStyle(InsetGroupedListStyle())
        }
    }

    func save() {
        let id = UUID()
        if let data = image?.pngData() {
            noteData.saveImage(id: id, data: data)
        }
        let newNote = Note(id: id, title: titleInput, content: contentInput, imageURLAppendix: image == nil ? nil : "\(id).png")
        noteData.notes.append(newNote)
        noteData.saveNotes()

        // 将目前用户输入的内容清空
        titleInput = ""
        contentInput = ""
        image = nil
    }

    func delete(at offsets: IndexSet) {
        noteData.notes.remove(atOffsets: offsets)
        noteData.saveNotes()
    }
}

#Preview {
    NoteEntryAndList()
}
