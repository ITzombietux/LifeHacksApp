//
//  StorageController.swift
//  LifeHacksApp
//
//  Created by zombietux on 11/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import Foundation

class StorageController {
    private let documentsDirectoryURL = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!
    
    private var userFileURL: URL {
        return documentsDirectoryURL
            .appendingPathComponent("User")
            .appendingPathExtension("plist")
    }
    
    func fetchTopQuestions() -> [Question]? {
        guard let dataFileURL = Bundle.main.url(forResource: "Data", withExtension: "plist"),
            let plistData = try? Data(contentsOf: dataFileURL) else {
                return nil
        }
        let decoder = PropertyListDecoder()
        return try? decoder.decode([Question].self, from: plistData)
    }
    
    func save(_ user: User) {
        let encoder = PropertyListEncoder()
        if let data = try? encoder.encode(user) {
            try? data.write(to: userFileURL)
        }
    }
    
    func fetchUser() -> User {
        let defaultUser = User(name: "John Doe", aboutMe: "I am the user of this app", profileImage: "Avatar", reputation: 100)
        guard let plistData = try? Data(contentsOf: userFileURL) else {
            return defaultUser
        }
        let decoder = PropertyListDecoder()
        return (try? decoder.decode(User.self, from: plistData)) ?? defaultUser
    }
}
