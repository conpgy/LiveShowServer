//
//  WebsocketIncomingSocketProcessor.swift
//  Live
//
//  Created by penggenyong on 2017/1/5.
//
//

import Foundation
import KituraNet
import Axis
import WebSocket

class WebsocketIncomingSocketProcessor: IncomingSocketProcessor {
    
    var keepAliveUntil: TimeInterval = 0.0
    
    var inProgress: Bool = true
    
    weak var handler: IncomingSocketHandler?
    
    var streamBuffer = Buffer()
    var bufferStream: BufferStream!
    
    var webSocket: WebSocket
    
    init() {
        
        bufferStream = BufferStream(buffer: streamBuffer)
        webSocket = WebSocket(stream: bufferStream, mode: .server)
        
        webSocket.onText { text in
            print("websocket text: \(text)")
        }
        
        webSocket.onPing { buffer in
            print("Ping")
        }
        
        webSocket.onPong { buffer in
            print("Pong")
        }
        
        webSocket.onClose { code in
            print("websocket close")
        }
    }
    
    
    func process(_ buffer: NSData) -> Bool {
        print("process buffer length: \(buffer.length)")
        
        
        var bytes = [UInt8](repeating: 0, count: buffer.length)
        buffer.getBytes(&bytes, length: bytes.count)
        
        streamBuffer.append(bytes, count: buffer.length)
        
        do {
            try webSocket.readStream()
        } catch let error {
            print(error)
        }
        
        return true
    }
    
    func write(from data: NSData) {
        handler?.write(from: data)
    }
    
    func write(from bytes: UnsafeRawPointer, length: Int) {
        handler?.write(from: bytes, length: length)
    }
    
    func close() {
        handler?.prepareToClose()
    }
    
    func socketClosed() {
    }
}
