//
//  RequestType.swift
//  ChatBot
//
//  Created by Jin-Mac on 3/26/24.
//

enum RequestType: CustomStringConvertible {
    case get
    case post
    case delete
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}
