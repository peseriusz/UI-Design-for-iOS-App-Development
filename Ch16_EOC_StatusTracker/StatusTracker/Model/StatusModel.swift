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

class UserStatusMgr : ObservableObject {
    static let instance = UserStatusMgr()
    @Published var userStatus = [UserStatus]()
    var subscriber : AnyCancellable?
    
    @Published var statusData = Data()
    var subscriberData : AnyCancellable?

    private init() {
        createSubscription()
        updateStatusData()
    }
    
    func createSubscription() {
        subscriberData = $statusData
            .flatMap{ data in
                        return Just(data)
                            .decode(type: [UserStatus].self,
                                                    decoder: JSONDecoder())
                                            .catch { _ in
                                                return Just(self.userStatus)
                                            }

                    }
            .receive(on: DispatchQueue.main)
            .assign(to: \.userStatus, on: self)

    }
    
    func updateStatusData() {

        #if DEBUG
        guard let urlLocal = Bundle.main.url(
                            forResource: "Status",
                                    withExtension: "json")
            else { return }
        if let data = try? Data(contentsOf: urlLocal) {
            DispatchQueue.global().async {
                self.statusData = data
            }
        }
//        return
        #else

        guard let url = URL(string:
                    "https://brainwashinc.com/Status.json")
                    else { return }
        
        subscriber = URLSession.shared
                    .dataTaskPublisher(for: url)
                    .map { $0.data }
                    .replaceError(with: self.statusData)
                    .assign(to: \.statusData, on: self)
        #endif
    }
}
