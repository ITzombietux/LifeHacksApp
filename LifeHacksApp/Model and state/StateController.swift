//
//  StateController.swift
//  LifeHacksApp
//
//  Created by zombietux on 05/12/2018.
//  Copyright © 2018 zombietux. All rights reserved.
//

import Foundation

class StateController {
    private let storageController = StorageController()
    
    var topQuestions: [Question]? {
        get { return storageController.fetchTopQuestions() }
        set {
            if let newQuestions = newValue {
                storageController.save(topQuestions: newQuestions)
            }
        }
    }
    
    var user: User {
        get { return storageController.fetchUser() }
        set { storageController.save(user: newValue) }
    }
    
    init() {
        self.topQuestions = storageController.fetchTopQuestions() ?? []
    }
    
    func updateQuestion(_ question: Question) {
        var questionIndex = 0
        guard let enumeratedQuestions = topQuestions?.enumerated() else {
            return
        }
        for (index, oldQuestion) in enumeratedQuestions {
            if oldQuestion == question {
                questionIndex = index
            }
        }
        topQuestions?[questionIndex] = question
    }
}
