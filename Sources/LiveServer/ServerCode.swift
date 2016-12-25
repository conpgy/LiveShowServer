//
//  ServerErrorCode.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/23.
//
//


enum ServerCode: Int {
    
    case success = 0
    case fail = 1
    case paramsError = 2
    case exception = -1
}
