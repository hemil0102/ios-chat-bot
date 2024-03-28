//
//  NetworkManager.swift
//  ChatBot
//
//  Created by Jin-Mac on 3/26/24.
//

import Foundation

protocol NetworkManagerProtocol {
    func request(request type: RequestType, url: URL, body: Data?, completion: @escaping ((Result<(Data?, HTTPURLResponse), NetworkError>) -> Void))
}

final class NetworkManager: NetworkManagerProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request(request type: RequestType, url: URL, body: Data?, completion: @escaping ((Result<(Data?, HTTPURLResponse), NetworkError>) -> Void)) {
    
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = type.description
        urlRequest.httpBody = body
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(.unknownError(message: error?.localizedDescription ?? "Unkown")))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.unsuccessfulResponse))
                return
            }
            
            if !(200...500).contains(response.statusCode) {
                // 서버통신 실패
                completion(.failure(.unsuccessfulResponse))
            }
            
            completion(.success((data, response)))
        }.resume()
    }
    
    func requestChatGPTFromServer<T: Decodable>(path: String, requestType type: RequestType, query: [URLQueryItem], dataType: T.Type) -> Result<T, NetworkError> {
        
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "api.openai.com"
        urlComponents.path = path
        urlComponents.queryItems = query
        guard let url = urlComponents.url else { return .failure(.invalidURL) }
        
        request(request: type, url: url, body: nil) { [weak self] result in
            var requstData: (Data?, HTTPURLResponse)
            switch result {
            case .success((let data, let response)):
                requstData = (data, response)
//                let networkResult = judgeStatus(by: response.statusCode, data, type: type)
            case .failure(let error):
                print(error)
            }
            let decodingData = self?.judgeStatus(by: requstData.1.statusCode, requstData.0, type: OpenAiChatBotDTO.self)
        }
    }
    
    func judgeStatus<T: Decodable>(by statusCode: Int, _ data: Data?, type: T.Type) -> Result<T, NetworkError> {
        let decoder = JSONDecoder()
        guard let data = data,
              let decodedData = try? decoder.decode(T.self, from: data) else {
            return .failure(.invalidURL)
        }
        
        switch statusCode {
        case 200..<300:
            return .success(decodedData)
        case 400..<500:
            return .failure(.unsuccessfulResponse)
        case 500..<600:
            return .failure(.unsuccessfulResponse)
        default:
            return .failure(.unknownError(message: "\(statusCode)"))
        }
    }
}
