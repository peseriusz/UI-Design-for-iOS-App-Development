//
//  ViewController.swift
//  CombineFW
//
//  Created by Bear Q Cahill on 8/20/20.
//  Copyright © 2020 BrainwashInc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var lbl: UILabel!
    var userText : String?

    @IBAction func textChange(sender : UITextField) {
        userText = sender.text
        lbl.text = userText
    }
    
}

