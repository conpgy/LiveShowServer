///
/// chat socket server
///


import LoggerAPI
import HeliumLogger
import Dispatch

let port = 9090

Log.logger = HeliumLogger()

let server = ChatServer(port: port)
print("Connect with a command line window by entering 'telnet 127.0.0.1 \(port)'")

server.run()
