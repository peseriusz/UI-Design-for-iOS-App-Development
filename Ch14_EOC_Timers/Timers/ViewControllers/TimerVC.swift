//
//  TimerVC.swift
//  Timers
//
//  Created by Bear Q Cahill 
//  Copyright © 2020 BrainwashInc. All rights reserved.
//

import UIKit

class TimerVC: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var pickerTimer: UIDatePicker!
    
    var name = ""
    var secs : TimeInterval = 0
    
    init?(timerName : String, timeSecs : TimeInterval, coder : NSCoder) {
        name = timerName
        secs = timeSecs
        super.init(coder: coder)
    }

    // not used
    required init?(coder: NSCoder) {
      fatalError("init(coder:) is not implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        name = tfName.text ?? ""
        secs = pickerTimer.countDownDuration
    }
}
