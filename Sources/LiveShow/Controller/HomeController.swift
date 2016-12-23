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
            
            let parameters = request.queryParameters
            
            var anchorsResponse = AnchorsResponse()
            
            guard let typeString = parameters["type"], let type = Int(typeString) else {
                
                anchorsResponse.message = "params type is empty"
                anchorsResponse.code = .paramsError
                JSON(anchorsResponse.dictionary) |> response.send(json:)
                response.status(.badRequest)
                try? response.end()
                return
                
            }
            
            var start = 0
            if let startString = parameters["start"], let paramsStart = Int(startString) {
                start = paramsStart
            }
            
            guard let pageSizeString = parameters["pageSize"], let pageSize = Int(pageSizeString) else {
                
                anchorsResponse.message = "pageSize is empty"
                anchorsResponse.code = .paramsError
                JSON(anchorsResponse.dictionary) |> response.send(json:)
                response.status(.badRequest)
                try? response.end()
                return
            }
            
            let selection = self.database.anchors(with: type, start: start, pageSize: pageSize)
            
            let _ = firstly {
                
                self.database.queryAnchors(with: selection)
                
                }.then(on: self.queue) { anchors in
                    
                    anchorsResponse.anchors.append(contentsOf: anchors)
                    anchorsResponse.code = .success
                    
                }.catch(on: self.queue) { error in
                    
                    Log.error(error.localizedDescription)
                    anchorsResponse.message = error.localizedDescription
                    
                }.always(on: self.queue) {
                    
                    JSON(anchorsResponse.dictionary) |> response.send(json:)
                    try? response.end()
                    nextHandler()
            }
        }
    }
    
}
