//
//  ContentView.swift
//  SUINotes
//
//  Created by Bear Q Cahill on 9/1/20.
//

import SwiftUI

struct MyStepper : View {
    @Binding var counter : Int
    var body: some View {
        Stepper("\(counter)", value: $counter,
                in: 0...9)
            .padding(.horizontal, 100)
    }
}

struct MyInput : View {
    @Binding var stringVal : String
    var body: some View {
        TextField("Enter Value:",
                  text: $stringVal,
                  onEditingChanged: { (changed) in
                    print (changed)
        }) {
            print ("commit: \(self.stringVal)")
        }
        .padding(.horizontal, 100)
    }
}

struct ContentView: View {
    @State private var counter : Int = 0
    @State private var username = ""

    var body: some View {
        VStack {
            MyStepper(counter: $counter)
            MyInput(stringVal: $username)
            Text(username)
        }
//        VStack {
//            Stepper(onIncrement: {
//                self.counter += 1
//            }, onDecrement: {
//                self.counter -= 1
//            }) {
//                Text.init("\(counter)").padding(10)
//            }
//            .padding(100)
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
