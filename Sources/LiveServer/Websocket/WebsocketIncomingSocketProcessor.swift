//
//  WebsocketIncomingSocketProcessor.swift
//  Live
//
//  Created by penggenyong on 2017/1/5.
//
//

import Foundation
import KituraNet

class WebsocketIncomingSocketProcessor: IncomingSocketProcessor {
    
    var keepAliveUntil: TimeInterval = 0.0
    
    var inProgress: Bool = true
    
    weak var handler: IncomingSocketHandler?
    
    func process(_ buffer: NSData) -> Bool {
        print("process buffer length: \(buffer.length)")
        return true
    }
    
    func write(from data: NSData) {
    }
    
    func write(from bytes: UnsafeRawPointer, length: Int) {
    }
    
    func close() {
    }
    
    func socketClosed() {
    }
}
