//
//  LiveShowServer.swift
//  LiveShowServer
//
//  Created by 彭根勇 on 2016/12/13.
//
//

import Foundation
import Kitura
import KituraRequest
import SwiftyJSON
import HeliumLogger
import LoggerAPI

public class LiveShowServer {
    
    let router = Router()
    
    init() {
        
        // 明星榜
        router.get("/rankStar") {
            request, response,nextHandler in
            self.rankRequest(url: Config.rankStarUrl, parameters: request.queryParameters, with: response)
            
            nextHandler()
        }
        
        // 富豪榜
        router.get("/rankWealth") {
            request, response,nextHandler in
            self.rankRequest(url: Config.rankWealthUrl, parameters: request.queryParameters, with: response)
            
            nextHandler()
        }
        
        // 人气榜
        router.get("/rankPopularity") {
            request, response,nextHandler in
            self.rankRequest(url: Config.rankPopularityUrl, parameters: request.queryParameters, with: response)
            
            nextHandler()
        }
        
        // 周星榜
        router.get("/rankAll") {
            request, response,nextHandler in
            self.rankRequest(url: Config.rankAllUrl, parameters: request.queryParameters, with: response)
            
            nextHandler()
        }
        
        
        router.get("/") {
            request, response,nextHandler in
            response.send("index")
            nextHandler()
        }
        
        // A custom Not found handler
        router.all { request, response, next in
            if  response.statusCode == .unknown  {
                // Remove this wrapping if statement, if you want to handle requests to / as well
                let path = request.urlComponents.path
                if  path != "/" && path != ""  {
                    try response.status(.notFound).send("Api not found!").end()
                }
            }
            next()
        }
        
    }
    
    // 启动服务器
    func run() -> Void {
        Kitura.addHTTPServer(onPort: Config.serverPort, with: router)
        Kitura.run()
    }
}

extension LiveShowServer {
    func rankRequest(url: String, parameters: [String:String], with response: RouterResponse) -> Void {
        
        KituraRequest.request(.get, url, parameters: parameters).response {
            _, _, data, error in
            
            guard let data = data else {
                return
            }
            
            let json = JSON(data: data)
            
            do {
                try response.send(json: json).end()
            } catch {
                Log.error("rank error. url: \(url)")
            }
        }
    }
}
