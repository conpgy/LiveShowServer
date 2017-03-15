import LoggerAPI
import HeliumLogger
import Dispatch
import KituraNet

Log.logger = HeliumLogger()

let server = LiveShowServer()
server.run()
