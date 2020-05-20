//
//  Networking.swift
//  VirtualTourist
//
//  Created by Jess Le on 5/2/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import Combine

enum NetworkError: Error {
    case parsing(description: String)
    case networking(description: String)
}
/**
 A protocol that is used for accessing the network data layer
 */
protocol Networkable: class {
    /**
     Deodes the given data via JSONDecoder.

     - Parameter data: Data to be decoded
     - Returns: A publisher, with either the decoded data on success, or a NetworkError on failure
     */
    func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, NetworkError>
    /**
     Performs a Get Request for the given URL and maps the response to the given Output type

     - Parameter url: The URL used to make the request
     - Returns: A publisher, with either the mapped Output on success,  or a NetworkError on failure
     */
    func taskForGetRequest<Output>(with url: URL) -> AnyPublisher<Output, NetworkError> where Output: Decodable
    /**
     Performs a Get Request for the given URLRequest and maps the response to the given Output type

     - Parameter request: The URLRequest used to make the request
     - Returns: A publisher, with either the mapped Output on success,  or a NetworkError on failure
     */
    func taskForGetRequest<Output>(with request: URLRequest) -> AnyPublisher<Output, NetworkError> where Output: Decodable
}

/**
A concrete implementation of `Networkable` that is used for accessing the network data layer
*/
public class NetworkService: Networkable {

    private let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    /**
    Decodes the given data via `JSONDecoder`.

    - Parameter data: Data to be decoded
    - Returns: A publisher, with either the decoded data on success, or a `NetworkError` on failure
    */
    func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, NetworkError> {
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .secondsSince1970
      return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
          NetworkError.parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }

    /**
    Performs a Get Request for the given URL and decodes and maps the response to the given `Output `type

    - Parameter url: The URL used to make the request
    - Returns: A publisher, with either the mapped `Output` on success,  or a `NetworkError` on failure
    */
    func taskForGetRequest<Output>(with url: URL) -> AnyPublisher<Output, NetworkError> where Output: Decodable {
        return urlSession
            .dataTaskPublisher(for: url)
            .mapError { error in
              NetworkError.networking(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                self.decode(pair.data)
            }
            .eraseToAnyPublisher()
    }

    /**
    Performs a Get Request for the given URLRequest and decodes and maps the response to the given `Output `type

    - Parameter request: The URLRequest used to make the request
    - Returns: A publisher, with either the mapped `Output` on success,  or a `NetworkError` on failure
    */
    func taskForGetRequest<Output>(with request: URLRequest) -> AnyPublisher<Output, NetworkError> where Output: Decodable {

        return urlSession
            .dataTaskPublisher(for: request)
            .mapError { error in
                NetworkError.networking(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                self.decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}
