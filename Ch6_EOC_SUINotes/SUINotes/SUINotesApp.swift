//
//  SUINotesApp.swift
//  SUINotes
//
//  Created by Bear Q Cahill on 9/1/20.
//

import SwiftUI

@main
struct SUINotesApp: App {
    var note : Note {
        let aNote = Note()
        aNote.text = "SUINotesApp.swift"
        return aNote
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.font,
                             Font.system(.largeTitle))
                            .environmentObject(note)
                            .environment(\.defaultNoteText, "New Default")
        }
    }
}
