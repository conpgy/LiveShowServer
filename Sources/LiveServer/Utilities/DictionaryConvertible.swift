//
//  DictionaryConvertible.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/22.
//
//


protocol DictionaryConvertible {
    var dictionary: [String: Any] {get}
}

extension Array where Element: DictionaryConvertible {
    var dictionary: [[String: Any]] {
        return self.map{$0.dictionary}
    }
}
