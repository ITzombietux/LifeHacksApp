//
//  SettingsController.swift
//  LifeHacksApp
//
//  Created by zombietux on 12/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import Foundation

class SettingsController {
    private let currentSchemeKey = "currentScheme"
    private let defaults = UserDefaults.standard
    
    var scheme: ColorScheme {
        get {
            guard let data = defaults.data(forKey: currentSchemeKey) else {
                return .defaultScheme
            }
            let decoder = PropertyListDecoder()
            return (try? decoder.decode(ColorScheme.self, from: data)) ?? .defaultScheme
        }
        set {
            if let data = encode(newValue) {
                defaults.setValue(data, forKey: currentSchemeKey)
            }
        }
    }
    
    init() {
        if let data = encode(.defaultScheme) {
            defaults.register(defaults: [currentSchemeKey: data])
        }
    }
}

private extension SettingsController {
    func encode(_ scheme: ColorScheme) -> Data? {
        let encoder = PropertyListEncoder()
        return try? encoder.encode(scheme)
    }
}
