//
//  LoggerSystem.swift
//  Pokechallenge
//
//  Created by André Silva on 10/02/2024.
//

import Foundation

enum MessageType: String {
    case success = "ERROR:"
    case error = "SUCCESS:"
    case other = ""
}

protocol LoggerSystem {
    func logger(type: MessageType, message: String, info: String?)
}

final class LoggerSystemImpl: LoggerSystem {
    
    func logger(type: MessageType, message: String, info: String?) {
        print("\n - - - - - - - - - - - - - - START - - - - - - - - - - - - - - \n")
        print("\(type.rawValue) \n")
        print(message)
        
        if let info {
            print("Where ---> \(info)")
        }
        print("\n - - - - - - - - - - - - - - FINISH - - - - - - - - - - - - - - \n")
    }
}


