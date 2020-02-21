//
//  DogAPI.swift
//  Randog
//
//  Created by Jess Le on 2/11/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import UIKit

class DogAPI {
    enum Endpoint {
        case randomImageAllDogs
        case randomImageForBreed(String)
        case breedsList
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageAllDogs:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .breedsList:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
        }
        task.resume()
    }
    
    class func requestRandomImage(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void) {
        let randomImageEndpoint = DogAPI.Endpoint.randomImageForBreed(breed).url
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
        guard let data = data else {
            completionHandler(nil, error)
            return
        }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            completionHandler(imageData, nil)
        }
        task.resume()
    }

    class func requestBreedsList(completionHandler: @escaping ([String], Error?) -> Void) {
        let allBreedsEndpoint = DogAPI.Endpoint.breedsList.url
        let task = URLSession.shared.dataTask(with: allBreedsEndpoint) { (data, response, error) in
        guard let data = data else {
            completionHandler([], error)
            return
        }
            let decoder = JSONDecoder()
            let breedResponse = try! decoder.decode(BreedResponse.self, from: data)
            let breeds = breedResponse.message.keys.map({$0})
            completionHandler(breeds, nil)
        }
        task.resume()
    }
}
