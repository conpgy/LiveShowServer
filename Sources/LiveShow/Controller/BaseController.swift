//
//  BaseController.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/22.
//
//

import Dispatch
import Kitura

class BaseController {
    
    let router: Router
    let database = Database.sharedInstance
    let queue = DispatchQueue(label: "com.liveshow-controller", attributes: .concurrent)
    
    init(_ router: Router) {
        self.router = router
    }
}
