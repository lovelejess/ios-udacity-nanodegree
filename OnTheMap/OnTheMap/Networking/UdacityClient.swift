//
//  UdacityAPI.swift
//  OnTheMap
//
//  Created by Jess Le on 2/23/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation

class UdacityClient {
    
    struct Auth {
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1/"
        
        case getSessionID
        
        var stringValue: String {
            switch self {
            case .getSessionID: return "https://onthemap-api.udacity.com/v1/session"
            }
        }

        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
   class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
    let credentials = Credentials(username: "jessicale90@gmail.com", password: "Gmpuf4qx")
    let body = SessionRequest(udacity: credentials)
        
    NetworkingRequester.taskForPOSTRequest(url: Endpoints.getSessionID.url, responseType: SessionResponse.self, body: body) { (response, error) in
            if let response = response {
                Auth.sessionId = response.session.id
                completion(true, nil)
            }
            else {
                completion(false, error)
            }
        }
    }

}


class NetworkingRequester {

    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let range = 5..<data.count
                let newData = data.subdata(in: range) // the first 4 characters are invalid, so need to parse data from 5th character
                print(String(data: newData, encoding: .utf8)!)
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                // TODO: Parse error response
                DispatchQueue.main.async {
                   completion(nil, error)
               }
            }
        }
        task.resume()
    }
    
}
