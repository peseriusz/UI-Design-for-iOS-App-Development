//
//  ViewController.swift
//  CombineFW
//
//  Created by Bear Q Cahill on 8/20/20.
//  Copyright © 2020 BrainwashInc. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var lbl: UILabel!
    var subscriber : AnyCancellable?

    @Published var userText : String? = ""
    var subscriber2 : AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscriber = NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification,
                       object: tf)
            .map { notif in
                guard let tf = notif.object as? UITextField
                    else { return "" }
                return tf.text
            }
            .assign(to: \.userText, on: self)
        
        subscriber2 = $userText
            .assign(to: \.text, on: lbl)
    }
}

