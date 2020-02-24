//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Jess Le on 2/23/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation

class UdacityService {
    
    struct Auth {
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1/"
        
        case getSessionID
        case getUserData(String)
        
        var stringValue: String {
            switch self {
            case .getSessionID: return "https://onthemap-api.udacity.com/v1/session"
            case .getUserData(let user): return "https://onthemap-api.udacity.com/v1/users/\(user)"
            }
        }

        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let credentials = Credentials(username: "jessicale90@gmail.com", password: "Gmpuf4qx")
        let body = SessionRequest(udacity: credentials)
            
        NetworkingRequester.POSTRequest(url: Endpoints.getSessionID.url, responseType: SessionResponse.self, body: body) { (response, error) in
            if let response = response {
                Auth.sessionId = response.session.id
                completion(true, nil)
            }
            else {
                completion(false, error)
            }
        }
    }
    
//    class func getUserData(user: String, completion: @escaping(User?, Error?) -> Void) {
//
//    }

}
