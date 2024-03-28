//
//  ViewController.swift
//  ChatBot
//
//  Created by Tacocat on 1/1/24.
//

import UIKit

class ViewController: UIViewController {
    
    let jsonDecoder: JsonDecodableProtocol = JsonDecoder(jsonDecoder: JSONDecoder())
    let jsonEncoder: JsonEncodableProtocol = JsonEncoder(jsonEncoder: JSONEncoder())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        print(makeHTTPBody())
    }
    
    private func makeHTTPBody() -> Result<Data?, JsonError> {
        let file = GPTRequestDTO(model: .basic, messages: [Message(role: .system, content: "You are an assistant that occasionally misspells words", toolCalls: nil), Message(role: .user, content: "Tell me a story.", toolCalls: nil)], logprobs: nil)
        
        return jsonEncoder.encode(of: file)
    }
    
    private func loadData() {
        let result: Result<GPTResponseDTO, JsonError> = jsonDecoder.decode(fileName: "responseData", fileType: "json")
        switch result {
        case .success(let data):
            print(data)
        case .failure(let error):
            print(error)
        }
    }
}
