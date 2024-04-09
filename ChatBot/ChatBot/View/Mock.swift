//
//  Mock.swift
//  ChatBot
//
//  Created by Jin-Mac on 4/9/24.
//

import Foundation

class Mock {
    static func getMockMessages() -> [(message: String, chatType: ChatBotRoomCollectionViewCell.ChatType)] {
        let messages = ["Mr. and Mrs. Dursley, of number four, Privet Drive, were proud to say",
                        "that they were perfectly normal, thank you very much. They were the last",
                        "people you'd expect to be involved in anything strange or mysterious",
                        "because they just didn't hold with such nonsense.",
        "Mr. Dursley was the director of a firm called Grunnings"]
        return messages.map { ($0, ChatBotRoomCollectionViewCell.ChatType.allCases.randomElement()!) }
    }
}
