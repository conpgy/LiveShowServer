//
//  ResponseFormat.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/23.
//
//

protocol ResponseFormat {
    var code: ServerCode {get}
    var message: String {get}
}
