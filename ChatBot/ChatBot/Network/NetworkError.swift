//
//  NetworkError.swift
//  ChatBot
//
//  Created by Jin-Mac on 3/26/24.
//

enum NetworkError: Error {
    case networkConnection
    case invalidURL
    case unsuccessfulResponse
    case unknownError(message: String)
    
    var localizedDescription: String {
        switch self {
        case .networkConnection:
            return "Check Network Connection"
        case .invalidURL:
            return "Invalid URL"
        case .unsuccessfulResponse:
            return "Unsuccessful Response"
        case .unknownError(let message):
            return "Unkown error : \(message)"
        }
    }
}
