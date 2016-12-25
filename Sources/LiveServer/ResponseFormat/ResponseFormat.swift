//
//  ResponseFormat.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/23.
//
//

protocol ResponseFormat: DictionaryConvertible {
    var code: ServerCode {get}
    var message: String {get}
}

struct BaseResponse: ResponseFormat {
    
    var code: ServerCode
    var message: String
    
    init(code: ServerCode = .exception, message: String = "exception") {
        self.code = code
        self.message = message
    }
}

extension BaseResponse: DictionaryConvertible {
    
    var dictionary: [String: Any] {
        return [
            "code": code.rawValue,
            "message": message
        ]
    }
}
