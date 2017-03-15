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


/// live home api
class HomeController: BaseController {
    
    override init(_ router: Router) {
        
        super.init(router)
        
//        router.get("/home/anchors") { request, response,nextHandler in
//            
//            let parameters = request.queryParameters
//            
//            var result = AnchorsFormatResult()
//            
//            guard let typeString = parameters["type"], let type = Int(typeString) else {
//                
//                result.message = "params type is empty"
//                result.code = .paramsError
//                self.sendFail(with: response, responseFormat: result)
//                return
//                
//            }
//            
//            var start = 0
//            if let startString = parameters["start"], let paramsStart = Int(startString) {
//                start = paramsStart
//            }
//            
//            guard let pageSizeString = parameters["pageSize"], let pageSize = Int(pageSizeString) else {
//                
//                result.message = "pageSize is empty"
//                result.code = .paramsError
//                self.sendFail(with: response, responseFormat: result)
//                return
//            }
//            
//            let selection = self.database.anchors(with: type, start: start, pageSize: pageSize)
//            
//            let _ = firstly {
//                
//                self.database.queryAnchors(with: selection)
//                
//                }.then(on: self.queue) { anchors in
//                    
//                    result.anchors.append(contentsOf: anchors)
//                    result.code = .success
//                    
//                }.catch(on: self.queue) { error in
//                    
//                    Log.error(error.localizedDescription)
//                    result.message = error.localizedDescription
//                    
//                }.always(on: self.queue) {
//                    
//                    JSON(result.dictionary) |> response.send(json:)
//                    try? response.end()
//                    nextHandler()
//            }
//        }
    }
    
}
