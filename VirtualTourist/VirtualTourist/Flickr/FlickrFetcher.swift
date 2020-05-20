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
//https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=c6a597c61edfdf422844c60e87e959ab&lat=37.76513627957266&lon=-104.991531&format=json&nojsoncallback=1
    enum Endpoints {
        static let scheme = "https"
        static let host = "www.flickr.com"
        static let path = "services/rest"
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
            components.path = Endpoints.path + "/lat/\(lat)/\(long)/"

            components.queryItems = [
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: "1"),
                URLQueryItem(name: "lat", value: lat),
                URLQueryItem(name: "lon", value: long),
                URLQueryItem(name: "apiKey", value: Endpoints.apiKey)
                
              ]

            return components.url!
        }
    }
}

struct FlickrResponse: Codable {
    let photos: PhotosResponse
    
}

struct PhotosResponse: Codable {
    let page: Int
    let pages: Int
    let photo: [Photo]
}

struct Photo: Codable {
    let id: Double
    let title: String
}
//{
//    "photos": {
//        "page": 1,
//        "pages": 1,
//        "perpage": 250,
//        "total": "12",
//        "photo": [
//            {
//                "id": "45824997834",
//                "owner": "18894742@N05",
//                "secret": "1c68cb63c5",
//                "server": "7923",
//                "farm": 8,
//                "title": "Walsenburg, Colorado",
//                "ispublic": 1,
//                "isfriend": 0,
//                "isfamily": 0
//            },
//            {
//                "id": "16498090365",
//                "owner": "79694975@N00",
//                "secret": "bca5bc9025",
//                "server": "8577",
//                "farm": 9,
//                "title": "Old Church at Sunset - Colorado",
//                "ispublic": 1,
//                "isfriend": 0,
//                "isfamily": 0
//            },
//            {
//                "id": "8301179919",
//                "owner": "28244217@N08",
//                "secret": "e6c6d20350",
//                "server": "8079",
//                "farm": 9,
//                "title": "IMG_0234.jpg",
//                "ispublic": 1,
//                "isfriend": 0,
//                "isfamily": 0
//            },
//            {
//                "id": "6268044000",
//                "owner": "33956830@N03",
//                "secret": "493da8f9a8",
//                "server": "6113",
//                "farm": 7,
//                "title": "shut the barn door or the horse might get out",
//                "ispublic": 1,
//                "isfriend": 0,
//                "isfamily": 0
//            },
//            {
//                "id": "5989142933",
//                "owner": "17299643@N00",
//                "secret": "3b63608a2d",
//                "server": "6028",
//                "farm": 7,
//                "title": "Camera Roll-116",
//                "ispublic": 1,
//                "isfriend": 0,
//                "isfamily": 0
//            },
//            {
//                "id": "3838233596",
//                "owner": "7840438@N08",
//                "secret": "3093009b0e",
//                "server": "2559",
//                "farm": 3,
//                "title": "CO 69 Turkey Creek Huerfano County",
//                "ispublic": 1,
//                "isfriend": 0,
//                "isfamily": 0
//            },
//            {
//                "id": "3475395208",
//                "owner": "23789188@N04",
//                "secret": "41750941c6",
//                "server": "3306",
//                "farm": 4,
//                "title": "Head of the Arroyo",
//                "ispublic": 1,
//                "isfriend": 0,
//                "isfamily": 0
//            },
//            {
//                "id": "3474533683",
//                "owner": "23789188@N04",
//                "secret": "692b6478bd",
//                "server": "3327",
//                "farm": 4,
//                "title": "Bend in Greasewood",
//                "ispublic": 1,
//                "isfriend": 0,
//                "isfamily": 0
//            },
//            {
//                "id": "3475313476",
//                "owner": "23789188@N04",
//                "secret": "4c0ffe5cdf",
//                "server": "3335",
//                "farm": 4,
//                "title": "Badito Cone Beyond Rugged Terrain",
//                "ispublic": 1,
//                "isfriend": 0,
//                "isfamily": 0
//            },
//            {
//                "id": "3475205190",
//                "owner": "23789188@N04",
//                "secret": "f7fee54154",
//                "server": "3351",
//                "farm": 4,
//                "title": "Greenhorn Beyond the Yuccas",
//                "ispublic": 1,
//                "isfriend": 0,
//                "isfamily": 0
//            },
//            {
//                "id": "3474370293",
//                "owner": "23789188@N04",
//                "secret": "7c91dc236d",
//                "server": "3622",
//                "farm": 4,
//                "title": "Greenhorn from Greasewood Arroyo",
//                "ispublic": 1,
//                "isfriend": 0,
//                "isfamily": 0
//            },
//            {
//                "id": "3470506508",
//                "owner": "23789188@N04",
//                "secret": "2bcaff1a47",
//                "server": "3637",
//                "farm": 4,
//                "title": "Deadly Dung",
//                "ispublic": 1,
//                "isfriend": 0,
//                "isfamily": 0
//            }
//        ]
//    },
//    "stat": "ok"
//}
