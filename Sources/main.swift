import LoggerAPI
import HeliumLogger


Log.logger = HeliumLogger()

// start server
let server = LiveShowServer()

server.run()
