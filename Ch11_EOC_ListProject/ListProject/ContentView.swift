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
        NavigationView {
            List {
                ForEach(items.indices) { (noteIndex) in
                    NavigationLink(destination:
                    NoteView(noteVM: self.$items[noteIndex])) {
                        NoteRow(noteVM: self.items[noteIndex])
                    }
                }
                .onDelete { offsets in
                    self.items.remove(atOffsets: offsets)
                }
            }.navigationBarTitle("Notes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
