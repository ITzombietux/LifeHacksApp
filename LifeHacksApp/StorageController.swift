//
//  StorageController.swift
//  LifeHacksApp
//
//  Created by zombietux on 11/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import Foundation

class StorageController {
    func fetchTopQuestions() -> [Question]? {
        guard let dataFileURL = Bundle.main.url(forResource: "Data", withExtension: "plist"),
            let plistData = try? Data(contentsOf: dataFileURL) else {
                return nil
        }
        let decoder = PropertyListDecoder()
        return try? decoder.decode([Question].self, from: plistData)
    }
}
