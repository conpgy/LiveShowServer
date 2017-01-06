//
//  WebsocketUpgradeFactory.swift
//  Live
//
//  Created by penggenyong on 2017/1/5.
//
//

import KituraNet
import Axis
import WebSocket

class WebsocketUpgradeFactory: ConnectionUpgradeFactory {
    
    let name = "websocket"
    var processor: WebsocketIncomingSocketProcessor!
    
    
    func upgrade(handler: IncomingSocketHandler, request: ServerRequest, response: ServerResponse) -> (IncomingSocketProcessor?, String?) {
        
        
        if let secKey = request.headers["Sec-WebSocket-Key"]?.first {
            print("Sec-WebSocket-Key: " + secKey)
            if let secValue = WebSocket.accept(secKey) {
                print("Sec-WebSocket-Accept: " + secValue)
                response.headers.append("Sec-WebSocket-Accept", value: [secValue])
            }
        }
        
        if processor == nil {
            processor = WebsocketIncomingSocketProcessor()
        }
        
        return (processor, nil)
    }
    
}
