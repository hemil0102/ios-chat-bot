//
//  OpenAiChatBotDTO.swift
//  ChatBot
//
//  Created by Jin-Mac on 3/26/24.
//

import Foundation

struct OpenAiChatBotDTO: Decodable {
    let id, object: String
    let created: Int
    let model: String
    let choices: [Choice]
    let usage: Usage
    let systemFingerprint: String

    enum CodingKeys: String, CodingKey {
        case id, object, created, model, choices, usage
        case systemFingerprint = "system_fingerprint"
    }
}

struct Choice: Decodable {
    let index: Int
    let message: Message
    let logprobs: Logprobs?
    let finishReason: String

    enum CodingKeys: String, CodingKey {
        case index, message, logprobs
        case finishReason = "finish_reason"
    }
}

struct Message: Decodable {
    let content: String?
    let toolCalls: [ToolCalls]
    let role: String
}

struct ToolCalls: Decodable {
    let id, type: String
    let function: Function
}

struct Function: Decodable {
    let name, arguments: String
}

struct Logprobs: Decodable {
    let content: [Content]?
}

struct Content: Decodable {
    let token: String
    let logprob: Double
    let bytes: [Int]?
    let topLogprobs: [TopLogprobs]
}

struct TopLogprobs: Decodable {
    let token: String
    let logprob: Double
    let buyes: [Int]?
}

struct Usage: Decodable {
    let promptTokens, completionTokens, totalTokens: Int

    enum CodingKeys: String, CodingKey {
        case promptTokens = "prompt_tokens"
        case completionTokens = "completion_tokens"
        case totalTokens = "total_tokens"
    }
}
