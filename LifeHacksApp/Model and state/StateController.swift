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
    private (set) var topQuestions: [Question] = StateController.createQuestions()
    
    var user: User {
        get { return storageController.fetchUser() }
        set { storageController.save(newValue) }
    }
    
    init() {
        self.topQuestions = storageController.fetchTopQuestions() ?? []
    }
    
    func updateQuestion(_ question: Question) {
        var questionIndex = 0
        for (index, oldQuestion) in topQuestions.enumerated() {
            if oldQuestion == question {
                questionIndex = index
            }
        }
        topQuestions[questionIndex] = question
    }
}

private extension StateController {
    class func createQuestions() -> [Question] {
        let question1: Question = {
            let title = "How to find a hole in a bicycle tire tube quickly"
            let body = "The tube inside by bicycle tire (inner-tube) got a hole and now I can't ride the bike. It isn't a big hole, so I am going to repair it myself. The only problem is that it takes an extremely long time to find the hole. I usually run my finger around the entire tube looking for it, until I eventually find it. This usually takesN 20-30 minutes. There must be an better alternative. What is an easy way to quickly find a hole in a tire tube?"
            let owner = User(name: "michalepri", aboutMe: "Moderator Pro Tempore on Lifehacks.SE", profileImage: "michaelpri", reputation: 5276)
            return Question(title: title, body: body, score: 24, owner: owner)
        }()
        let question2: Question = {
            let title = "Stop keyboard wobble due to uneven desk"
            let body = "I've just acquired and finished setting up a new wooden plank computer desk. Upon finishing the new setup I naturally went to use my keyboard and noticed that the wooden planks aren't exactly flush resulting in my keyboard wobbling with each keystroke as shown below."
            let owner = User(name: "Daniel Storm", aboutMe: "Developing iOS applications to help you waste time, effectively. Latest application: Zero Views", profileImage: "DanielStorm", reputation: 194)
            return Question(title: title, body: body, score: 17, owner: owner)
        }()
        let question3: Question = {
            let title = "How to transport single servings of powdered drink mixes"
            let body = "There are lots of drink mixes that come in powdered form: protein powders, meal replacement shake mixes, etc.\n \n Usually these come in a big container of powder with a little scoop, and you scoop out the right amount and mix it with water.\n \n How can I carry some single serving sizes of powder with me to mix with water while I'm on the go? I thought about using ziploc bags but it's hard to pour from the bag into the water cup without spilling powder everywhere."
            let owner = User(name: "Thomas Johnson", aboutMe: "Apparently, this user prefers to keep an air of mystery about them.", profileImage: "Thomas Johnson", reputation: 153)
            return Question(title: title, body: body, score: 10, owner: owner)
        }()
        return [question1, question2, question3]
    }
}
