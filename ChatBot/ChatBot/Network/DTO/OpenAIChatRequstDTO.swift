//
//  OpenAIChatRequstDTO.swift
//  ChatBot
//
//  Created by Jin-Mac on 3/27/24.
//

import Foundation

struct OpenAIChatRequstDTO: Encodable {
    let model: String = "gpt-3.5-turbo-1106"
    let stream: Bool = false
    let messages: [Message]
}
