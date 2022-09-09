//
//  ViewController.swift
//  Timers
//
//  Created by Bear Q Cahill on 8/19/20.
//  Copyright © 2020 BrainwashInc. All rights reserved.
//

import UIKit
import SwiftUI

class TimerListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var timerVC : TimerVC?
    var timers = [TimerItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        #if DEBUG
        timers.append(TimerItem(name: "Test 1", seconds: 3723))
        timers.append(TimerItem(name: "Test 2", seconds: 13023))
        timers.append(TimerItem(name: "Test 3", seconds: 723))
        timers.append(TimerItem(name: "Test Short", seconds: 5))
        #endif
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            guard error == nil, granted == true else { return }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let tvc = timerVC {
            guard tvc.name.count > 0 else { return }
            let newTimer = TimerItem(name: tvc.name, seconds: tvc.secs)
            timers.insert(newTimer, at: 0)
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
        timerVC = nil
    }
    
    @IBSegueAction func makeTimer(_ coder: NSCoder) -> TimerVC? {
        // new timer: no name, default 60 seconds
        timerVC = TimerVC(timerName: "", timeSecs: 60, coder: coder)
        return timerVC
    }
    
    @IBSegueAction func timerDetails(_ coder: NSCoder) -> UIViewController? {
        let timer = timers[tableView.indexPathForSelectedRow!.row]
        let tView = TimerView(timer: timer)

        return UIHostingController(coder: coder,
                                   rootView: tView)
    }
    
    
}

extension TimerListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTimer", for: indexPath)
        
        let timer = timers[indexPath.row]
        cell.textLabel?.text = timer.name
        cell.detailTextLabel?.text = timer.timeString
        cell.detailTextLabel?.textColor = timer.isDone ? .red : .label
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Remove") { (action, view, handler) in
            self.timers.remove(at: indexPath.row)
            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
            handler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let timer = timers[indexPath.row]
        if timer.isRunning {
            let stopAction = UIContextualAction(style: .destructive, title: "Pause") { (action, view, handler) in
                timer.pause()
                handler(true)
            }
            return UISwipeActionsConfiguration(actions: [stopAction])
        }
        
        let startAction = UIContextualAction(style: .normal, title: "Start") { (action, view, handler) in
            timer.start()
            handler(true)
        }
        return UISwipeActionsConfiguration(actions: [startAction])

    }
    
}
