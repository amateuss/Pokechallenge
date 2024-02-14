//
//  NetworkService.swift
//  Pokechallenge
//
//  Created by André Silva on 12/02/2024.
//

import Foundation

protocol NetworkService {
    typealias CompletionHandler = (Result<Data, Error>) -> Void
    func requestData(from url: URL, completion: @escaping CompletionHandler)
}
