import LoggerAPI
import HeliumLogger
import Dispatch
import KituraNet

Log.logger = HeliumLogger()


// 注册websocket处理器
ConnectionUpgrader.register(factory: WebsocketUpgradeFactory())

let server = LiveShowServer()
server.run()
