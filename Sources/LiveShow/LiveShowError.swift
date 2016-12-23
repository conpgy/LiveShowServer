//
//  LiveShowError.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/19.
//
//

import Foundation

enum LiveShowError: Error {
    case noConnection
    case noResult
    case invalidLengthQuery(String)
    case insertionProblem
    case badRequest
    case databaseError(String)
}

extension LiveShowError: LocalizedError {
    
    var errorDescription: String? {
        
        switch self {
            
        case .noConnection:
            return "Could not make a connection"
            
        case .noResult:
            return "No result"
            
        case .invalidLengthQuery(let query):
            return "\(query) was too short"
            
        case .insertionProblem:
            return "Could not insert the element"
            
        case .badRequest:
            return "There was a bad request"
            
        case .databaseError(let message):
            return "Database error: \(message)"
        }
        
    }
    
}
