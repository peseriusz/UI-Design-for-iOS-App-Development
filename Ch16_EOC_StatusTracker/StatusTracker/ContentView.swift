//
//  ContentView.swift
//  StatusTracker
//
//  Created by Bear Cahill on 9/14/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var mgr = UserStatusMgr.instance
    @State private var filterIndex : Int = Status.all.rawValue
    private var filterStatus : Status {
        Status(rawValue: self.filterIndex)!
    }
    
    var body: some View {
        VStack {
            Text("Status App")
                .fontWeight(.heavy)
            Picker("", selection: $filterIndex) {
                ForEach(0..<Status.totalNum) { (index) in
                    Text(Status(rawValue: index)!.description)
                }
            }.pickerStyle(SegmentedPickerStyle())
            
            List {
                ForEach(mgr.userStatus.filter
                { $0.status == self.filterStatus
                    || self.filterStatus == .all
                }, id: \.id) { item in
                    HStack {
                        Text(item.username)
                        Spacer()
                        Text(item.status.description)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
