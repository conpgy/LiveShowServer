//
//  WebChatServer.swift
//  Live
//
//  Created by penggenyong on 2016/12/30.
//
//

import Foundation
import WebSocket
import Axis

class WebChatServer: Axis.InputStream, Axis.OutputStream {
    
    let websocket: WebSocket
    
    init() {
        
//        websocket = WebSocket(stream: self, mode: .server)
    }
    
}
