//
//  PhotoAlbumViewModel.swift
//  VirtualTourist
//
//  Created by Jess Le on 5/2/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

class PhotoAlbumViewModel {

    private var subscribers = Set<AnyCancellable>()

    var userPreferences: UserPreferences!
    var coordinator: Coordinatable!
    var dataController: DataController!
    var dataFetcher: FlickrFetchable!
    
    @Published
    var photos: [Photo] = []

    var delegate: TravelLocationsMapDelegate?

    init(coordinator: Coordinatable, userPreferences: UserPreferences = UserPreferences(), dataController: DataController, dataFetcher: FlickrFetchable) {
        self.coordinator = coordinator
        self.userPreferences = userPreferences
        self.dataController = dataController
        self.dataFetcher = dataFetcher
    }

    func getPhotos() {
        let location = CLLocationCoordinate2D(latitude: 37.76513627957266, longitude: -104.991531)
        dataFetcher.photosForLocation(forGeocode: location)
            .receive(on: DispatchQueue.main).sink(receiveCompletion: { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .failure:
                    self.photos = []
                case .finished:
                    break
                }
            }) { [weak self] response in
                guard let self = self else { return }
                guard let photosMetadata = response.photosMetadata else { self.photos = []; return }
                self.photos = photosMetadata.photos
        }.store(in: &subscribers)
    }
    
}
