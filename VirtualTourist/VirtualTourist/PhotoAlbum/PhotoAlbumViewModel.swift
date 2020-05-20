//
//  PhotoAlbumViewModel.swift
//  VirtualTourist
//
//  Created by Jess Le on 5/2/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation

class PhotoAlbumViewModel {
    
    var photos: [Photo] = []
    var userPreferences: UserPreferences!
    var coordinator: Coordinatable!
    var dataController: DataController!

    var delegate: TravelLocationsMapDelegate?
    
    init(coordinator: Coordinatable, userPreferences: UserPreferences = UserPreferences(), dataController: DataController) {
        self.coordinator = coordinator
        self.userPreferences = userPreferences
        self.dataController = dataController
    }
    
}
