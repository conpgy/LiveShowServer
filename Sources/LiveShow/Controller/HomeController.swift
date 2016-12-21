//
//  HomeController.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/21.
//
//

import Foundation

class HomeController {
    
    let router = LiveShowServer.sharedInstance.router
    
    init() {
        
        router.get("/home/anchors") { request, response,nextHandler in
            response.send("anchors")
            nextHandler()
        }
    }
    
}
