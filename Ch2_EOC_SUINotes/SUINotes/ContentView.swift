//
//  ContentView.swift
//  SUINotes
//
//  Created by Bear Q Cahill on 9/1/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Notes")
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(30.0)
                .frame(width: 300.0, height: 50.0)
                .background(Color.blue)
                .cornerRadius(15.0)
            Text("This has a red border.")
                .border(/*@START_MENU_TOKEN@*/Color.red/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            Text("This has a black background but opacity of 0.5. It has multiple lines but doesn't go off the screen and is left justified. It also has some padding to keep from the edges and the item above.")
                .foregroundColor(Color.white)
                .background(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .opacity(0.5)
                .padding(45)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
