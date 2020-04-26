//
//  UserPreferences.swift
//  VirtualTourist
//
//  Created by Jess Le on 4/25/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import MapKit

class UserPreferences {
    var userDefaults: UserDefaults!

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    var location: Location? {
        set {
            setValue(key: .location, value: newValue)
        }
        get {
            return getValue(key: .location)
        }
    }

    private func getValue<T: Codable>(key: UserPreferenceKeys) -> T? {
        if let valueData = userDefaults.data(forKey: key.rawValue) {
            let decoder = JSONDecoder()
            if let value = try? decoder.decode(T.self, from: valueData) {
                return value
            } else if T.self == Bool.self {
                return false as? T
            }
        }
        return (T.self == Bool.self) ? false as? T : nil
    }

    private func setValue<T: Codable>(key: UserPreferenceKeys, value: T?) {
        let encoder = JSONEncoder()
        if let encodedValue = try? encoder.encode(value) {
            userDefaults.set(encodedValue, forKey: key.rawValue)
        }
    }
}

enum UserPreferenceKeys: String {
    case location
}
