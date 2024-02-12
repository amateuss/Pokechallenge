//
//  LoggerSystem.swift
//  Pokechallenge
//
//  Created by André Silva on 10/02/2024.
//

import Foundation

protocol LoggerSystem {
    func logger(info: String, message: String?, error: String?)
}

final class LoggerSystemImpl: LoggerSystem {
    
    func logger(info: String, message: String? = nil, error: String? = nil) {
        print("\n - - - - - - - - - - - - - - START - - - - - - - - - - - - - - \n")

        if let message = message {
            print("Message:")
            print(message)
        }
        
        if let error = error {
            print("ERROR:")
            print("\(error)")
        }
        
        print("Where ---> \(info)")

        print("\n - - - - - - - - - - - - - - FINISH - - - - - - - - - - - - - - \n")
    }
}
