//
//  HomeController.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/21.
//
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI
import MiniPromiseKit
import SwiftyJSON

class HomeController: BaseController {
    
    override init(_ router: Router) {
        
        super.init(router)
        
        router.get("/home/anchors") { request, response,nextHandler in
            
            do {
                
                let parameters = request.queryParameters
                
                guard let typeString = parameters["type"], let type = Int(typeString) else {
                    try response.send("anchors").end()
                    return
                }
                guard let startString = parameters["start"], let start = Int(startString) else {
                    try response.send("anchors").end()
                    return
                }
                guard let pageSizeString = parameters["pageSize"], let pageSize = Int(pageSizeString) else {
                    try response.send("anchors").end()
                    return
                }
                
                let selection = self.database.anchors(with: type, start: start, pageSize: pageSize)
                
                let _ = firstly {
                    
                    self.database.queryAnchors(with: selection)
                    
                }.then(on: self.queue) { anchors in
                    
                    JSON(anchors.dictionary) |> response.send(json:)
                    try response.end()
                    
                }.catch(on: self.queue) { error in
                    
                    Log.error(error.localizedDescription)
                    response.send(error.localizedDescription)
                    
                    try? response.end()
                    
                    
                }.always {
                    nextHandler()
                }
                
            } catch {
                Log.error("/home/anchors: " + error.localizedDescription)
            }
        }
    }
    
}
