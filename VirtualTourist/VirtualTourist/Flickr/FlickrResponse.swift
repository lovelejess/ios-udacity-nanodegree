//
//  FlickrResponse.swift
//  VirtualTourist
//
//  Created by Jess Lê on 5/24/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation

struct FlickrResponse: Codable, Hashable {
    let identifier = UUID()
    let photosMetadata: PhotosResponse?
    
    enum CodingKeys: String, CodingKey {
        case photosMetadata = "photos"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: FlickrResponse, rhs: FlickrResponse) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

struct PhotosResponse: Codable {
    let total: String
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case total
        case photos = "photo"
    }
}

struct Photo: Codable, Hashable {
    let id: String
    let title: String
    let secret: String
    let server: String
    let farm: Int
}

