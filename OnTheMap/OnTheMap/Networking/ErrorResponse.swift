//
//  ErrorResponse.swift
//  OnTheMap
//
//  Created by Jess Le on 4/12/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation

class ErrorResponse: Codable {
    let status: Int
    let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case errorMessage = "error"
    }

    init(status: Int, errorMessage: String) {
        self.status = status
        self.errorMessage = errorMessage
    }
}

enum LoginError: Error {
    case invalidCredentials(description: String)
}
