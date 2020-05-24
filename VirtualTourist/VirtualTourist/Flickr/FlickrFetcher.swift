//
//  FlickrFetcher.swift
//  VirtualTourist
//
//  Created by Jess Le on 5/2/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import Combine
import MapKit

/**
A protocol that is used for accessing the network data layer for Flicker Data
*/
protocol FlickrFetchable: class {
    /**
    Gets photos based on the given geocde. Returns a `FlickrResponse` on success, or a `NetworkError` on failure.

    - Parameter geocode: The gecode used to retrieve the Flick Photos
    - Returns: A publisher, with either the mapped `FlickrResponse` on success,  or a `NetworkError` on failure
    */
    func photosForLocation(forGeocode geocode: CLLocationCoordinate2D) -> AnyPublisher<FlickrResponse, NetworkError>

}

/**
A concrete implementation of `FlickrFetchable`  that is used for retrieving flickr data from the Flickr API
*/
class FlickrFetcher: FlickrFetchable {

    private let networkService: Networkable

    init(networkService: Networkable) {
        self.networkService = networkService
    }

    /**
      Gets photos  based on the given gecode. Returns a `FlickrResponse` on success, or a `NetworkError` on failure.

    - Parameter geocode: The gecode used to retrieve Photos
    - Returns: A publisher, with either the mapped `FlickrResponse` on success,  or a `NetworkError` on failure
    */
    func photosForLocation(forGeocode geocode: CLLocationCoordinate2D) -> AnyPublisher<FlickrResponse, NetworkError> {
        print("URL: \(FlickrFetcher.Endpoints.photosForLocation(geocode: geocode).url)")
        return flickr(with: FlickrFetcher.Endpoints.photosForLocation(geocode: geocode).url)
    }

    private func flickr<Output>(with url: URL) -> AnyPublisher<Output, NetworkError> where Output: Decodable {
        return networkService.taskForGetRequest(with: url)
    }
}

// MARK: Flickr Endpoints
extension FlickrFetcher {

    struct FickrPath {
        static let photosForLocation = "flickr.photos.search"
    }

    enum Endpoints {
        static let scheme = "https"
        static let host = "flickr.com"
        static let path = "/services/rest/"
        static let apiKey = "c6a597c61edfdf422844c60e87e959ab"

        case photosForLocation(geocode: CLLocationCoordinate2D)

        var url: URL {
            switch self {
            case .photosForLocation(let geocode): return createURL(for: FickrPath.photosForLocation, geocode: geocode)
            }
        }

        func createURL(for type: String, geocode: CLLocationCoordinate2D) -> URL {
            let lat = String(geocode.latitude)
            let long = String(geocode.longitude)
            var components = URLComponents()
            components.scheme = Endpoints.scheme
            components.host = Endpoints.host
            components.path = Endpoints.path

            components.queryItems = [
                URLQueryItem(name: "api_key", value: Endpoints.apiKey),
                URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "lat", value: lat),
                URLQueryItem(name: "lon", value: long),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: "1"),
              ]

            return components.url!
        }
    }
}
