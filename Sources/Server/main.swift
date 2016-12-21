import LoggerAPI
import HeliumLogger
import LiveShow
import Foundation


Log.logger = HeliumLogger()

// start server
let server = LiveShowServer.sharedInstance

server.run()
