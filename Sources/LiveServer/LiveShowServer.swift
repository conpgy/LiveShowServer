//
//  LiveShowServer.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/13.
//
//

import Dispatch
import Kitura
import KituraRequest
import SwiftyJSON
import HeliumLogger
import LoggerAPI
import Stencil
import KituraStencil
import KituraMustache

import MiniPromiseKit

public class LiveShowServer {
    
    let router = Router()
    let database = Database.sharedInstance
    let queue = DispatchQueue(label: "com.liveshow-server", attributes: .concurrent)
    
    var controllers = [BaseController]()
    
    public init() {
        
        // 静态文件服务
        router.all("/static", middleware: StaticFileServer())
        
        // 注册stencil模板引擎
        let nameSpace = Namespace()
        nameSpace.registerSimpleTag("custom") { _ in
            return "Hello world"
        }
        router.add(templateEngine: StencilTemplateEngine(namespace: nameSpace))
        
        // register controller
        registerControllers()
        
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
            
            var params = request.queryParameters;
            params["imei"] = "36301BB0-8BBA-48B0-91F5-33F1517FA056"
            
            if let type = params["type"] {
                if let number = Int(type) {
                    params["signature"] = number == 0 ? "b4523db381213dde637a2e407f6737a6" : "d23e92d56b1f1ac6644e5820eb336c3e"
                    params["ts"] = number == 0 ? "1480399365" : "1480414121"
                    params["weekly"] = "\(number)"
                    params["pageSize"]="30" // 不传30不行啊
                    params.removeValue(forKey: "type")
                }
            }
            
            print("rankAll params: \(params)")
            
            self.rankRequest(url: Config.rankAllUrl, parameters: params, with: response)
            
            nextHandler()
        }
        
        

        
        
//        router.get("/play/live") {
//            request, response,nextHandler in
//            
//            
//            var params = [String: String]()
//            params["imei"] =  "36301BB0-8BBA-48B0-91F5-33F1517FA056"
//            params["signature"] = "f69f4d7d2feb3840f9294179cbcb913f"
//            params["roomId"] = request.queryParameters["roomId"] ?? ""
//            params["userId"] = request.queryParameters["userId"] ?? ""
//            
//            
//            KituraRequest.request(.get, Config.preLoadingLiveUrl, parameters: params).response {
//                _, _, data, error in
//                
//                guard let data = data else {
//                    return
//                }
//                let json = JSON(data: data)
//                print(json)
//                
//                guard let rUrl = json["message"]["rUrl"].string else {
//                    return
//                }
//                
//                KituraRequest.request(.get, rUrl).response({ (_, _, liveData, liverError) in
//                    guard let liveData = liveData else {
//                        return
//                    }
//                    let liveJson = JSON(data:liveData)
//                    guard let liveUrl = liveJson["url"].string else {
//                        return
//                    }
//                    
//                    do {
//                        try response.send(liveUrl).end()
//                    } catch {
//                        Log.error("get liver url fail..")
//                    }
//                })
//                
//                
//            }
//            nextHandler()
//        }
        
        
        router.get("/chat") {
            request, response, next in
            
            do {
                try response.send("Hello").end()
            } catch let error {
                print(error)
            }
            next()
        }
        
        
        router.get("/") {
            request, response,nextHandler in
            
            let _ = firstly {
                
                // query and update pv
                self.database.queryAndUpdatePV()
                
            }.then(on: self.queue) { pv in
                
                let context = ["pv": pv]
                try response.render("index.stencil", context: context).end()
                
            }.catch(on: self.queue) { error in
                
                response.status(.badRequest).send(error.localizedDescription)
                
            }.always {
                nextHandler()
            }
        }

        
        // A custom Not found handler
        router.all { request, response, next in
            if  response.statusCode == .unknown  {
                // Remove this wrapping if statement, if you want to handle requests to / as well
                let path = request.urlURL.path
                if  path != "/" && path != ""  {
                    
                    JSON(BaseResponse().dictionary) |> response.send(json:)
                    try response.end()
                }
            }
            next()
        }
        
    }
    
    private func registerControllers() {
        controllers.append(HomeController(router))
        controllers.append(LiveController(router))
    }
    
    // 启动服务器
    public func run() -> Void {
        Kitura.addHTTPServer(onPort: Config.serverPort, with: router)
        Kitura.run()
    }
}

extension LiveShowServer {
    
    /// rank request
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
                Log.error("request error. url: \(url)")
            }
        }
    }
}
