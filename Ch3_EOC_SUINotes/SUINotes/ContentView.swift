//
//  ContentView.swift
//  SUINotes
//
//  Created by Bear Q Cahill on 9/1/20.
//

import SwiftUI

struct ContentView: View {
    @State private var isReady = false
    @State private var username = ""
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding(30)
            Text(username)
            
            Text("Hello, Swift")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
                .padding(30.0)
                .frame(width: 200.0, height: 400.0)
                .background(/*@START_MENU_TOKEN@*/Color.green/*@END_MENU_TOKEN@*/) 
                .cornerRadius(/*@START_MENU_TOKEN@*/40.0/*@END_MENU_TOKEN@*/)
            Button(action: {
                print ("tapped!")
                self.isReady.toggle()
//                self.username = "Bear"
            }, label: { Text("Tap Me") })
                .disabled(self.username.count == 0)
            
            Text("another item")
            
            Image(systemName: "camera")
            Image("brainwashIcon")
                .resizable()
                .colorInvert()
                .frame(width: 100, height: 100,
                       alignment: .center)
            
            Toggle(isOn: $isReady,
                   label: {
                    Text("Ready: " + (isReady ? "Yes" : "No"))
            })
                .padding([.leading, .trailing], 100.0)
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
