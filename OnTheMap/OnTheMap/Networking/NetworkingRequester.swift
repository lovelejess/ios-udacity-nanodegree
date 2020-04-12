//
//  NetworkingRequester.swift
//  OnTheMap
//
//  Created by Jess Le on 2/23/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation

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
