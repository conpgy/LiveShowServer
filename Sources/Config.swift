//
//  Config.swift
//  LiveShowServer
//
//  Created by 彭根勇 on 2016/12/13.
//
//

import Foundation

class Config {
    
    static let databaseUserName = "penggenyong"
    static let databasePassword = "password"
    static let databaseHost = "localhost"
    static let databasePort = Int32(5432)
    static let databaseName = "live_show"
    
    static let serverPort = 8092
    
    
    // api url
    static let domain = "http://qf.56.com"
    static let rankStarUrl = domain + "/rank/v1/rankStar.ios"
    static let rankWealthUrl = domain + "/rank/v1/rankWealth.ios"
    static let rankPopularityUrl = domain + "/rank/v1/rankPopularity.ios"
    static let rankAllUrl = domain + "/rank/v1/rankAll.ios"
    static let guessUrl = domain + "/home/v4/guess.ios"
    static let moreAnchorUrl = domain + "/home/v4/moreAnchor.ios"
    static let giftListUrl = domain + "/pay/v4/giftList.ios"
    static let preLoadingUrl = domain + "/pay/v2/preLoading.ios"
}
