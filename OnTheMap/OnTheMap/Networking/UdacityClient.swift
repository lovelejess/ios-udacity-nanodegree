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
        case studentsLocation
        case studentsLocationByKey(String)
        case studentsLocationByOrder(String)

        var stringValue: String {
            switch self {
            case .getSessionID: return Endpoints.base + "session"
            case .studentsLocation: return Endpoints.base + "StudentLocation?limit=100"
            case .studentsLocationByKey(let key): return Endpoints.base + "StudentLocation?uniqueKey=\(key)"
            case .studentsLocationByOrder(let order): return Endpoints.base + "StudentLocation?order=\(order)"
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

class NetworkingRequester {

    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, ErrorResponse?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    let errorResponse = parseErrorResponse(data: nil, error: error)
                    DispatchQueue.main.async {
                       completion(nil, errorResponse)
                    }
                }
                return
            }
            let decoder = JSONDecoder()
            let range = 5..<data.count
            let newData = data.subdata(in: range) // the first 4 characters are invalid, so need to parse data from 5th character
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                let errorResponse = parseErrorResponse(data: newData, error: nil)
                DispatchQueue.main.async {
                   completion(nil, errorResponse)
                }
           }
        }
        task.resume()
    }
    
    class func taskForGETRequest<ResponseType: Codable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, error)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }

    class func parseErrorResponse(data: Data?, error: Error?) -> ErrorResponse? {
        if let data = data {
            do {
                let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                return errorResponse
            } catch {
                return nil
            }
        }
        if let error = error {
            return ErrorResponse(status: 500, errorMessage: error.localizedDescription)
        }
        return nil
    }
}


enum LoginError: Error {
    case invalidCredentials(description: String)
    
}

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
