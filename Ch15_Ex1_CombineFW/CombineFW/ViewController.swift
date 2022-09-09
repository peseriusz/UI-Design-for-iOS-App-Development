//
//  ViewController.swift
//  CombineFW
//
//  Created by Bear Q Cahill on 8/20/20.
//  Copyright © 2020 BrainwashInc. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController, Subscriber {
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var lbl: UILabel!
    var userText : String?

    typealias Input = Notification
    typealias Failure = Never
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    func receive(_ input: Input) -> Subscribers.Demand {
        if let textField = input.object as? UITextField {
            userText = textField.text
            lbl.text = userText
        }
        return .unlimited
    }
    func receive(completion: Subscribers.Completion<Failure>) {
        print(completion)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let publisher = NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification,
                       object: tf)

        publisher
            .receive(on: DispatchQueue.main)
            .subscribe(self)
//            .subscribe(on: DispatchQueue.main)
//            .receive(subscriber: self)
    }
    
    @IBAction func textChange(sender : UITextField) {
//        userText = sender.text
//        lbl.text = userText
    }
    
}

