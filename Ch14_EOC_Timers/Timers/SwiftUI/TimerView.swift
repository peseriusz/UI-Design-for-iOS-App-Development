//
//  TimerView.swift
//  Timers
//
//  Created by Bear Cahill on 9/14/20.
//  Copyright © 2020 BrainwashInc. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timer : TimerItem
    
    var body: some View {
        VStack {
            Text(timer.name)
            Text(timer.timeString)
            .font(.largeTitle)
            .padding()
            Button(action: {
                if self.timer.isRunning {
                    self.timer.pause()
                }
                else {
                    self.timer.start()
                }
            }) {
                Text(timer.isRunning ? "Pause" : "Start")
            }

        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var timer = TimerItem(name: "Test Timer",
            seconds: 12)
    static var previews: some View {
        TimerView(timer: timer)
    }
}
