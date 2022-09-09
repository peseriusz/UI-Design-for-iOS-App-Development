//
//  NoteView.swift
//  ListProject
//
//  Created by Bear Q Cahill
//  Copyright © 2020 BrainwashInc. All rights reserved.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String
 
    func makeUIView(context: Context) -> UITextView {
        return UITextView()
    }
 
    func updateUIView(_ tvNote: UITextView, context: Context) {
        tvNote.text = text
    }
}

struct NoteView : View {
    @Binding var noteVM : NoteViewModel
    
    var body: some View {
        VStack {
            NotePriorityAndTime(noteVM: noteVM)
            Spacer()
//                Text(noteVM.text)
            TextView(text: $noteVM.text)
                .border(Color.gray, width: 1)
            Spacer()
            Image(noteVM.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }.padding()
    }
}

struct NoteView_Previews: PreviewProvider {
    @State static var noteVM =
        NoteViewModel.loadTestData().last!
    static var previews: some View {
        NoteView(noteVM: $noteVM)
    }
}


