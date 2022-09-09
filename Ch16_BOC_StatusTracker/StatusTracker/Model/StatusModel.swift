//
//  StatusModel.swift
//  StatusTracker
//
//  Created by Bear Q Cahill on 8/21/20.
//  Copyright © 2020 BrainwashInc. All rights reserved.
//

import Foundation
import Combine

enum Status : Int, Codable, CaseIterable {
    case offline, paused, live, all
    
    static var totalNum : Int {
        return Status.allCases.count
    }
    
    var description : String {
        switch self {
        case .offline:
            return "Offline"
        case .paused:
            return "Paused"
        case .live:
            return "Live"
        case .all:
            return "All"
        }
    }
}

struct UserStatus : Codable {
    var id = 0
    var username = ""
    var status = Status.offline
}

class UserStatusMgr {
    static let instance = UserStatusMgr()
    var userStatus = [UserStatus]()
}
