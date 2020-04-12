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
        static let studentLocationBase = "\(base)StudentLocation?limit=100"
        case getSessionID
        case studentsLocation
        case studentsLocationByKey(String)
        case studentsLocationByOrder(String)

        var stringValue: String {
            switch self {
            case .getSessionID: return Endpoints.base + "session"
            case .studentsLocation: return Endpoints.studentLocationBase
            case .studentsLocationByKey(let key): return Endpoints.studentLocationBase + "&uniqueKey=\(key)"
            case .studentsLocationByOrder(let order): return Endpoints.studentLocationBase + "&order=\(order)"
            }
        }

        var url: URL {
            return URL(string: stringValue)!
        }
    }

    class func login(username: String, password: String, completion: @escaping (SessionResponse?, ErrorResponse?) -> Void) {
        let credentials = Credentials(username: username, password: password)
        let body = SessionRequest(udacity: credentials)

        NetworkingRequester.taskForPOSTRequest(url: Endpoints.getSessionID.url, responseType: SessionResponse.self, body: body) { (response, error) in
            if let response = response {
                completion(response, nil)
            }
            else {
                completion(nil, error)
            }
        }
    }

    class func getStudentsLocation(completion: @escaping ([StudentInformation], Error?) -> Void) {
        NetworkingRequester.taskForGETRequest(url: Endpoints.studentsLocation.url, responseType: Students.self) { (response, error) in
            if let response = response {
                completion(response.results, nil)
            }
            else {
                completion([], error)
            }
        }
    }
    
    class func getStudentsLocationByUniqueKey(for key: String, completion: @escaping ([StudentInformation], Error?) -> Void) {
        NetworkingRequester.taskForGETRequest(url: Endpoints.studentsLocationByKey(key).url, responseType: Students.self) { (response, error) in
            if let response = response {
                completion(response.results, nil)
            }
            else {
                completion([], error)
            }
        }
    }
    
    class func getStudentsLocationByOrder(for order: String, completion: @escaping ([StudentInformation], Error?) -> Void) {
        NetworkingRequester.taskForGETRequest(url: Endpoints.studentsLocationByOrder(order).url, responseType: Students.self) { (response, error) in
            if let response = response {
                completion(response.results, nil)
            }
            else {
                completion([], error)
            }
        }
    }

    class func postStudentsLocation(body: StudentLocationRequest, completion: @escaping (StudentLocationPostingResponse?, ErrorResponse?) -> Void) {
        NetworkingRequester.taskForPOSTRequest(url: Endpoints.studentsLocation.url, responseType: StudentLocationPostingResponse.self, body: body) { (response, error) in
            if let response = response {
                completion(response, nil)
            }
            else {
                completion(nil, error)
            }
        }
    }
}
