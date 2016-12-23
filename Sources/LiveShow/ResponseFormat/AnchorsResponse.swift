//
//  AnchorsResponse.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/23.
//
//


struct AnchorsResponse: ResponseFormat {
    
    var code:ServerCode
    var message: String
    var anchors = [Anchor]()
    
    init(code: ServerCode = .fail, message: String = "") {
        self.code = code
        self.message = message
    }
}

extension AnchorsResponse: DictionaryConvertible {
    
    var dictionary: [String: Any] {
        var dict = [String: Any]()
        dict["code"] = code.rawValue
        dict["message"] = message
        dict["anchors"] = anchors.dictionary
        
        return dict
    }
}
