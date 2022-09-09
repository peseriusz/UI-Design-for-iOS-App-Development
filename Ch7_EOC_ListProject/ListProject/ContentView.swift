//
//  ContentView.swift
//  ListProject
//
//  Created by Bear Q Cahill on 8/31/20.
//

import SwiftUI

struct ContentView: View {
    let df = DateFormatter()
    @State private var notes = Note.createTestNotes()
    
    init() {
        df.dateStyle = .none
        df.timeStyle = .medium
    }
    
    var body: some View {
        List {
            ForEach(notes, id: \.id) { note in
                NoteRow(note: note, df: self.df)
            }
            .onDelete { offsets in
                self.notes.remove(atOffsets: offsets)
            }
        }
//        List(notes) { note in
//            NoteRow(note: note, df: self.df)
//        }
//        List(0..<19) { index in
//            NoteRow(note: Note(), df: self.df)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
