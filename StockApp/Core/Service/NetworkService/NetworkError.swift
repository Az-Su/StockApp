//
//  NetworkError.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 25.01.2023.
//

import Foundation

enum NetworkError: String, Error {
    case missingURL
    case missingRequest
    case taskError
    case responseError
    case dataError
    case decodeError
}
