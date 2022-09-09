//
//  ContentView.swift
//  Popups
//
//  Created by Bear Cahill on 9/15/20.
//

import SwiftUI

struct User : Identifiable {
    var id = UUID()
    var name = "Test"
}

struct ContentView: View {
    @State var alert = false
    @State var user : User?
    
    @State var actionSheet = false
    
    @State var sheet = false
    
    @State var popover = false
    
    var body: some View {
        VStack {
            Button("Alert!") {
                $alert.wrappedValue = true
            }
            .alert(isPresented: $alert, content: {
                Alert(title: Text("Alert!"),
                    message: Text("You tapped the button."),
                    primaryButton: .default(Text("OK")),
                    secondaryButton: .cancel({
                    self.user = User()
                    })
                )
            })
            Text("Second")
            .alert(item: $user) { (theUser) -> Alert in
                Alert(title: Text("Cancel?"),
                      message: Text("\(theUser.name)")
                )
            }
            
            Button("Action Sheet") {
                $actionSheet.wrappedValue = true
            }
            .actionSheet(isPresented: $actionSheet, content: {
                ActionSheet(title: Text("Action"),
                            message: Text("Go!"),
                            buttons:
                                [.destructive(Text("Delete"))]
                )
            })
            
            Button("Sheet") {
                $sheet.wrappedValue = true
            }
            .sheet(isPresented: $sheet, content: {
                VStack {
                    Text ("Tap to Dismiss")
                    Button("Dismiss") {
                        $sheet.wrappedValue = false
                    }
                }
            })
            
            Button("Popover") {
                $popover.wrappedValue = true
            }
            .popover(isPresented: $popover,
                     attachmentAnchor: .point(.trailing),
                     arrowEdge: .leading,
                     content: {
                Text("Popover! Here we are just...")
                    .lineLimit(2)
                    .frame(width: 300, height: 300,
                    alignment: .center)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
