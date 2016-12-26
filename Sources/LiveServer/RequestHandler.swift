//
//  RequestHandler.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/22.
//
//

import Foundation
import Kitura

protocol RequestHandler: class {
    var router: Router {get}
}
