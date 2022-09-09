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

class Note : ObservableObject {
    var text = "" {
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
    }
}

struct ContentView: View {
    @ObservedObject var note = Note()
    var df = DateFormatter()

    init() {
        df.dateStyle = .none
        df.timeStyle = .medium
        note.text = "Note Text"
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
            Button(action: {
                let newTime = self.df.string(from:
                    Date())
                self.note.text = "now \(newTime)"
                print (self.note.text)
            }) {
                Text ("Update")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
