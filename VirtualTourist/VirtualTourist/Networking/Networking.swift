//
//  NetworkService.swift
//  VirtualTourist
//
//  Created by Jess Lê on 5/24/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import Combine

enum NetworkError: Error {
    case networking(description: String)
    case parsing(description: String)
}

/**
 A protocol that is used for accessing the network data layer
 */
protocol Networkable: class {
    /**
    Decodes the given data via JSONDecoder

     - Parameter data: The data to be decoded
     - Returns: A publisher, with either the decoded data on success, or a `NetworkError` on failure
     */
    func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, NetworkError>

    /**
    Performs a GET request for the given URL and maps the response to the given Output type

     - Parameter request: The url used to make the GET request
     - Returns: A publisher, with either the decoded data on success, or a `NetworkError` on failure
     */
    func taskForGetRequest<Output>(with request: URL) -> AnyPublisher<Output, NetworkError> where Output: Decodable
}

/**
 A concrete implementation of `Networkable` that is used for accessing the Network Data Layer
 */
class NetworkService: Networkable {
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
    Performs a GET request for the given URL and maps the response to the given Output type

     - Parameter request: The url used to make the GET request
     - Returns: A publisher, with either the decoded data on success, or a `NetworkError` on failure
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
}
