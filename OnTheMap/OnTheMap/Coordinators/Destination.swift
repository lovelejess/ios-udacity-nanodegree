//
//  Destination.swift
//  OnTheMap
//
//  Created by Jess Le on 3/1/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation

enum Destination {
    case addPin
    case login
    case logout
    case mainTabBar(Tab)
    
    enum Tab {
        case mainMapView
    }
}

