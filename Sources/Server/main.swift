import LoggerAPI
import HeliumLogger
import LiveShow


Log.logger = HeliumLogger()

// start server
let server = LiveShowServer()

server.run()
