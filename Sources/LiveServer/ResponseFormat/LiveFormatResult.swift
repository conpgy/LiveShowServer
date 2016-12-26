//
//  LiveResultFormat.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/23.
//
//


struct LiveFormatResult: ResponseFormat {
    var code:ServerCode
    var message: String
    var url: String
    
    init(code: ServerCode = .fail, message: String = "") {
        self.code = code
        self.message = message
        self.url = ""
    }
    
    var dictionary: [String: Any] {
        var dict = [String: Any]()
        dict["code"] = code.rawValue
        dict["message"] = message
        dict["url"] = url
        
        return dict
    }
}
