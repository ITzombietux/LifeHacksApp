//
//  Model.swift
//  LifeHacksApp
//
//  Created by zombietux on 03/12/2018.
//  Copyright © 2018 zombietux. All rights reserved.
//

import Foundation

struct User {
    let name:String
    let aboutMe:String
    let profileImage:String
    let reputation:Int
}

struct Question {
    let title: String
    let body: String
    private (set) var score: Int
    let owner: User
    
    mutating func voteUp() {
        score += 1
    }
    
    mutating func voteDown() {
        score -= 1
    }
}
