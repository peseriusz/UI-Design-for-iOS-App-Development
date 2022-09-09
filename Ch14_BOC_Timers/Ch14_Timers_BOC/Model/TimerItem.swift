//
//  Timer.swift
//  Timers
//
//  Created by Bear Q Cahill on 8/19/20.
//  Copyright © 2020 BrainwashInc. All rights reserved.
//

import Foundation
import UserNotifications

class TimerItem  {
    var name = ""
    var seconds : TimeInterval = 0
    var secondsOrig : TimeInterval = 0
    var isDone : Bool = false
    var isRunning = false
    
    var timeString = ""

    private var timerTimer : Timer?
    private var secsTimer : Timer?
    
    init() {}
    
    init(name : String, seconds : TimeInterval) {
        self.name = name
        self.seconds = seconds
        self.secondsOrig = seconds
        self.timeString = self._timerString
    }
    
    private var _timerString : String {
        let secondsRemaining = seconds
        let hours = Int(secondsRemaining / 3600)
        let mins = Int(secondsRemaining.truncatingRemainder(dividingBy: 3600) / 60)
        let secs = Int(secondsRemaining.truncatingRemainder(dividingBy: 60))
        return String(format: "%@%@%02d:%02d",
                            "\(hours > 0 ? "\(hours)" : "")",
                            "\(hours > 0 ? ":" : "")",
                            abs(mins),
                            abs(secs))
    }
    
    func pause() {
        isRunning = false
        secsTimer?.invalidate()
        timerTimer?.invalidate()
        
        let identifier = "\(self.name)-\(self.secondsOrig)"
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }

    func start() {
        if !isRunning {
            let content = UNMutableNotificationContent()
            content.body = "Timer \(name) is done!"
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
            let req = UNNotificationRequest(identifier: "\(name)-\(secondsOrig)", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(req) { (error) in
                // handle error
            }
        }
        isRunning = true
        
        secsTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            self.seconds -= 1
            
            if self.seconds == 0 {
                self.pause()
                self.isDone = true
                self.seconds = self.secondsOrig
                #if DEBUG
                print ("\(self.name) timer done")
                #endif
            }
            self.timeString = self._timerString
        }
    }
}
