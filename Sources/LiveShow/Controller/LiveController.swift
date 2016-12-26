//
//  LiveController.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/23.
//
//

import Kitura
import HeliumLogger
import LoggerAPI
import MiniPromiseKit
import SwiftyJSON

class LiveController: BaseController {
    
    override init(_ router: Router) {
        
        super.init(router)
        
        router.get("/play/live/url") { request, response, next in
            
            
            guard let roomIdStr = request.queryParameters["roomId"], let roomId = Int(roomIdStr) else {
                self.sendFail(with: response, responseFormat: BaseResponse(message:"roomId empty"))
                return
            }
            
        
            var liveFormatResult = LiveFormatResult()
            
            
            let _ = firstly {
                
                self.database.queryLiveUrl(roomId: roomId)
                
            }.then (on: self.queue) { url in
                
                liveFormatResult.url = url
                
            }.catch(on: self.queue) { error in
                    
                Log.error(error.localizedDescription)
                liveFormatResult.message = error.localizedDescription
                    
            }.always(on: self.queue) {
                    
                JSON(liveFormatResult.dictionary) |> response.send(json:)
                try? response.end()
                next()
            }
            
        }
        
        router.get("/live") { request, response, next in
            
            do {
                try response.render("live.stencil", context: [:]).end()
            } catch let error {
                print("live error: \(error.localizedDescription)")
            }
            
        }
    }
}
