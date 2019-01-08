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
    let score: Int
    let owner: User
}
