//
//  StorageController.swift
//  LifeHacksApp
//
//  Created by zombietux on 11/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import Foundation

class StorageController {
    private let cachesDirectoryURL = FileManager.default
        .urls(for: .cachesDirectory, in: .userDomainMask)
        .first!
    
    func save(topQuestions: [Question]) {
        save(value: topQuestions)
    }
    
    func fetchTopQuestions() -> [Question]? {
        return fetch()
    }
    
    func save(user: User) {
        save(value: user)
    }
    
    func fetchUser() -> User {
        let defaultUser = User(id: 0, name: "John Doe", aboutMe: "I am the user of this app", profileImageURL: URL(string: "Avatar")!, reputation: 100)
        guard let user: User = fetch() else {
            return defaultUser
        }
        return user
    }
}

private extension StorageController {
    func fileUrl<T>(for type: T.Type) -> URL {
        return cachesDirectoryURL
            .appendingPathComponent(String(describing: type))
            .appendingPathExtension("plist")
    }
    
    func fetch<V: Decodable>() -> V? {
        guard let plistData = try? Data(contentsOf: fileUrl(for: V.self)) else {
            return nil
        }
        let decoder = PropertyListDecoder()
        return try? decoder.decode(V.self, from: plistData)
    }
    
    func save<V: Encodable> (value: V) {
        let encoder = PropertyListEncoder()
        if let plistData = try? encoder.encode(value) {
            try? plistData.write(to: fileUrl(for: V.self))
        }
    }
}
