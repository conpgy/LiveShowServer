import Foundation
import Dispatch
import Socket
import LoggerAPI


public class ChatServer {
	
    static let quitCommand = "QUIT"
    static let shutdownCommand = "SHUTDOWN"
    static let bufferSize = 4096
    
    let port: Int
    var listenSocket: Socket?
    var continueRunning = true
    var connectedSockets = [Int32: Socket]()
    var socketLockQueue = DispatchQueue(label: "com.onejiall.socketLockQueue")
    
    
    public init(port: Int) {
        self.port = port
    }
    
    deinit {
        for socket in connectedSockets.values {
            socket.close()
        }
        listenSocket?.close()
    }
    
    public func run() {
        
        do {
            try self.listenSocket = Socket.create()
            guard let socket = self.listenSocket else {
                print("Unable to unwrap socket...")
                return
            }
            
            try socket.listen(on: self.port)
            
            listen(with: socket)
            
            print("Listening on port: \(socket.listeningPort)")
            
        } catch let error {
            guard let socketError = error as? Socket.Error else {
                print("Unexpected error...")
                return
            }
            
            if self.continueRunning {
                print("Error reported:\n \(socketError.description)")
            }
        }
    }
    
    func listen(with listenSocket: Socket) {
        
        do {
            repeat {
                let newSocket = try listenSocket.acceptClientConnection()
                print("Accepted connection from: \(newSocket.remoteHostname) on port \(newSocket.remotePort)")
                print("Socket Signature: \(newSocket.signature?.description)")
                
                self.addNewConnection(socket: newSocket)
                
            } while listenSocket.isListening
            
        } catch let error {
            Log.error("Error accepting client connection: \(error)")
        }

        
    }
    
    func addNewConnection(socket: Socket) {
        
        socketLockQueue.sync {
            self.connectedSockets[socket.socketfd] = socket
        }
        
        let queue = DispatchQueue.global(qos: .default)
        
        queue.async { [unowned self] in
            
            var shouldKeepRunning = true
            var readData = Data(capacity: ChatServer.bufferSize)
            
            do {
                
                repeat {
                    let byteRead = try socket.read(into: &readData)
                    
                    if byteRead > 0 {
                        guard let response = String(data: readData, encoding: .utf8) else {
                            print("Error decoding response...")
                            readData.count = 0
                            break
                        }
                        if response.hasPrefix(ChatServer.shutdownCommand) {
                            print("Shutdown requested by connection at \(socket.remoteHostname) on port \(socket.remotePort)")
                            self.shutdownServer()
                            return
                        }
                        print("Server received from connection at \(socket.remoteHostname) on port \(socket.remotePort)")
                        let reply = "Server response: \n\(response)\n"
                        try socket.write(from: reply)
                        
                        if (response.uppercased().hasPrefix(ChatServer.quitCommand) || response.uppercased().hasPrefix(ChatServer.shutdownCommand))
                            && (!response.hasPrefix(ChatServer.quitCommand))
                            && (!response.hasPrefix(ChatServer.shutdownCommand)) {
                            try socket.write(from: "If you want to QUIT or SHUTDOWN, please type the name in all caps. \n")
                        }
                        
                        if response.hasPrefix(ChatServer.quitCommand) || response.hasSuffix(ChatServer.quitCommand) {
                            shouldKeepRunning = false
                        }
                    }
                    
                    if byteRead == 0 {
                        shouldKeepRunning = false
                        break
                    }
                    
                    readData.count = 0
                    
                } while shouldKeepRunning
                
                print("Socket: \(socket.remoteHostname):\(socket.remotePort) closed ...")
                socket.close()
                
                self.socketLockQueue.sync { [unowned self, socket] in
                    self.connectedSockets[socket.socketfd] = nil
                }
                
            } catch let error {
                guard let socketError = error as? Socket.Error else {
                    print("Unexpected error by connection at \(socket.remoteHostname):\(socket.remotePort)")
                    return
                }
                if self.continueRunning {
                    print("Error reported by connection at \(socket.remoteHostname):\(socket.remotePort):\n \(socketError.description)")
                }
            }
        }
        
    }
    
    func shutdownServer() {
        print("Shutdown in progress....")
        continueRunning = false
        
        // close all open sockets
        for socket in connectedSockets.values {
            socket.close()
        }
        
        listenSocket?.close()
        
        DispatchQueue.main.sync {
            exit(0)
        }
    }
}

