//
//  NetworkService.swift
//  Pokechallenge
//
//  Created by André Silva on 10/02/2024.
//

import Foundation

protocol NetworkService {
    typealias CompletionHandler = (Result<Data, Error>) -> Void
    func requestData(from url: URL, completion: @escaping CompletionHandler)
}

class NetworkServiceImpl: NetworkService {
    private let session: URLSession
    private let loggerSystem: LoggerSystem
    
    init(session: URLSession = .shared, loggerSystem: LoggerSystem = LoggerSystemImpl()) {
        self.session = session
        self.loggerSystem = loggerSystem
    }
    
    func requestData(from url: URL, completion: @escaping CompletionHandler) {
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                self.loggerSystem.logger(info: "File: \(#fileID):\(#line) --> func: \(#function)", message: nil, error: error.localizedDescription)
                
                completion(.failure(NetworkError.invalidURL))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                self.loggerSystem.logger(info: "File: \(#fileID):\(#line) --> func: \(#function)", message: nil, error: NetworkError.invalidURL.description)
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                self.loggerSystem.logger(info: "File: \(#fileID):\(#line) --> func: \(#function)", message: nil, error: NetworkError.noData.description)
                completion(.failure(NetworkError.noData))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData

    var description: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "invalid Response"
        case .noData: return "No Data"
        }
    }
}

