//
//  BaseController.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/22.
//
//

import Dispatch
import Kitura
import SwiftyJSON

class BaseController {
    
    let router: Router
    let database = Database.sharedInstance
    let queue = DispatchQueue(label: "com.liveshow-controller", attributes: .concurrent)
    
    init(_ router: Router) {
        self.router = router
    }
    
    func sendFail(with response: RouterResponse, responseFormat: ResponseFormat) {

        JSON(responseFormat.dictionary) |> response.send(json:)
        response.status(.badRequest)
        try? response.end()
    }
}
