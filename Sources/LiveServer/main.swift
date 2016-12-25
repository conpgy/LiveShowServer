import LoggerAPI
import HeliumLogger
import Dispatch

Log.logger = HeliumLogger()

let server = LiveShowServer()
server.run()
