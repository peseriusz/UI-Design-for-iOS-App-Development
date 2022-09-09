//
//  ContentView.swift
//  ListProject
//
//  Created by Bear Q Cahill on 8/31/20.
//

import SwiftUI

struct ContentView: View {
    #if DEBUG
    @State private var items = NoteViewModel.loadTestData()
    #else
    @State private var items = [NoteViewModel]()
    #endif
    
    var body: some View {
    List {
        ForEach(items, id: \.id)
            { NoteRow(noteVM: $0) }
            .onDelete { offsets in
                self.items.remove(atOffsets: offsets)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
