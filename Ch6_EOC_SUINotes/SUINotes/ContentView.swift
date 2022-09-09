//
//  ContentView.swift
//  SUINotes
//
//  Created by Bear Q Cahill on 9/1/20.
//

import SwiftUI
import Combine

enum Priority : Int {
    case low, medium, high
}

struct NoteInitialTextEnvironmentKey: EnvironmentKey {
    static var defaultValue: String = "Default Note"
}

extension EnvironmentValues {
    var defaultNoteText: String {
        get {
            return
                self[NoteInitialTextEnvironmentKey.self]
        }
        set {
            self[NoteInitialTextEnvironmentKey.self] =
                newValue
        }
    }
}

class Note : ObservableObject {
    var text = EnvironmentValues()[NoteInitialTextEnvironmentKey.self] {
        didSet {
            self.updatedAtTime = Date()
//            self.objectWillChange.send()
        }
    }
    @Published var updatedAtTime = Date()
    var priority = Priority.low {
        didSet {
            self.updatedAtTime = Date()
        }
    }
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 10.0,
                             repeats: true) { (timer) in
            self.priority = Priority(rawValue:
                self.priority.rawValue + 1) ??
                Priority.high
            if self.priority == .high {
                timer.invalidate()
            }
        }
        print (EnvironmentValues()[NoteInitialTextEnvironmentKey.self])
    }
}

struct NoteView : View {
    @EnvironmentObject var note : Note
    var df = DateFormatter()

    init() {
        self.df.timeStyle = .medium
        self.df.dateFormat = .none
    }
    
    var body: some View {
        VStack {
            Text(note.text)
            Text(df.string(from: note.updatedAtTime))

            HStack {
                Image(systemName: "star.circle")
                Image(systemName: note.priority.rawValue > 0
                    ? "star.circle" : "circle")
                Image(systemName: note.priority.rawValue > 1
                    ? "star.circle" : "circle")
            }
            .padding(.bottom)
        }.background(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/)
    }
}
 
struct ContentView: View {
//    let note = Note()
//    var df = DateFormatter()
//    @Environment(\.colorScheme) var lightOrDark
//
//    init() {
//        df.dateStyle = .none
//        df.timeStyle = .medium
//    }

//    init() {
//        note.text = "Created in NoteView"
//    }

    var body: some View {
        VStack {
            NoteView()
                .environment(\.colorScheme, .dark)
        }
        // replace the Note in the child environment
//        .environmentObject(note)
    }
}

struct ContentView_Previews: PreviewProvider {
//    static var note = Note()
    static var note : Note {
        let note = Note()
        note.text = "Static Computed"
        return note
    }
    static var previews: some View {
        ContentView()
            .environmentObject(Note())
    }
}
