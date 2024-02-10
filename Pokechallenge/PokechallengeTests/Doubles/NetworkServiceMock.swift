//
//  NetworkServiceMock.swift
//  PokechallengeTests
//
//  Created by André Silva on 10/02/2024.
//

import Foundation
@testable import Pokechallenge

// MARK: - Mock Network Service
class NetworkServiceMock: NetworkService {
    var requestDataCalled = false
    var requestURL: URL?
    var result: Result<Data, Error>?

    func requestData(from url: URL, completion: @escaping NetworkService.CompletionHandler) {
        requestDataCalled = true
        requestURL = url
        if let result = result {
            completion(result)
        }
    }
}
