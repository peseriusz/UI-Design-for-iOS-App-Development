//
//  NoteRow.swift
//  ListProject
//
//  Created by Bear Q Cahill on 8/31/20.
//

import SwiftUI

enum Priority : Int {
    case low, medium, high
}

class Note : Identifiable {
    var id = UUID().uuidString
    var text = "New Note" {
        didSet {
            self.updatedAtTime = Date()
        }
    }
    var updatedAtTime = Date()
    var priority = Priority.low {
        didSet {
            self.updatedAtTime = Date()
        }
    }
    
    static func createTestNotes() -> [Note] {
        var items = [Note]()
        for i in 0..<19 {
            let note = Note()
            note.text = "\(i)"
            items.append(note)
        }
        return items
    }
}

struct NoteRow: View {
    var note : Note
    var df : DateFormatter
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(note.text)
            HStack {
                Image(systemName: "star.circle")
                Image(systemName: note.priority.rawValue > 0 ?
                    "star.circle" : "circle")
                Image(systemName: note.priority.rawValue > 1 ?
                    "star.circle" : "circle")
                Spacer()
                Text(df.string(from: note.updatedAtTime))
            }
        }
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        NoteRow(note: Note(), df: DateFormatter())
    }
}
