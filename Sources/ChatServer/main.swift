///
/// chat socket server
///


import LoggerAPI
import HeliumLogger
import Dispatch

let port = 9090

Log.logger = HeliumLogger()

let server = ChatServer(port: port)

server.run()
