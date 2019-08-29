//
//  ReachabilityUtility.swift
//  Pagination Demo
//
//  Created by mohamed on 8/29/19.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation
import Reachability

class ReachabilityUtility {
    
    static let shared = ReachabilityUtility()
    private let reachability = Reachability()
    
    var isReachable = Bool()
    
    private init() {}
    
    func reachabilityConfiguration(){
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        //isReachable = reachability?.connection == .some(.cellular) || reachability?.connection == .some(.wifi)
        
        reachability?.whenReachable = { [unowned self] reachability in
            self.isReachable = true
            if reachability.connection == .wifi {
                //Code when WIFI
            } else {
                //Code When Celler
            }
        }
        
        reachability?.whenUnreachable = { [unowned self] _ in
            self.isReachable = false
        }
    }
}
