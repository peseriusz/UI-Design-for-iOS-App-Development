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
                ForEach(items, id: \.id) { (noteVM)  in
                    NavigationLink(destination: Text(noteVM.text)) {
                        NoteRow(noteVM: noteVM)
                    }
                }
                .onDelete { offsets in
                    self.items.remove(atOffsets: offsets)
                }
//                .sheet(item: $selectedNoteVM) { (noteVM) in
//                    Text(noteVM.text)
//                }
            }
            .navigationBarTitle("Notes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
