//
//  WebsocketUpgradeFactory.swift
//  Live
//
//  Created by penggenyong on 2017/1/5.
//
//

import KituraNet
import WebSocket

class WebsocketUpgradeFactory: ConnectionUpgradeFactory {
    
    let name = "websocket"
    
    func upgrade(handler: IncomingSocketHandler, request: ServerRequest, response: ServerResponse) -> (IncomingSocketProcessor?, String?) {
        
        
        if let secKey = request.headers["Sec-WebSocket-Key"]?.first {
            print("Sec-WebSocket-Key: " + secKey)
            if let secValue = WebSocket.accept(secKey) {
                print("Sec-WebSocket-Accept: " + secValue)
                response.headers.append("Sec-WebSocket-Accept", value: [secValue])
//                response.headers.append("Sec-WebSocket-Accept", value: ["ddd"])
            }
        }
        
        return (WebsocketIncomingSocketProcessor(), nil)
    }
    
}
