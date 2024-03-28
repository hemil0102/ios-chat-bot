//
//  ChatMessageDTO.swift
//  ChatBot
//
//  Created by Jin-Mac on 3/28/24.
//

import Foundation

struct Message: Codable {
    let content: String?
    let toolCalls: [ToolCall]?
    let role: String
    
    enum CodingKeys: String, CodingKey {
        case content, role
        case toolCalls = "tool_calls"
    }
}

struct ToolCall: Codable {
    let id, type: String
    let function: Function
}

struct Function: Codable {
    let name, arguments: String
}
