//
//  Model.swift
//  LifeHacksApp
//
//  Created by zombietux on 03/12/2018.
//  Copyright © 2018 zombietux. All rights reserved.
//

import Foundation

struct User: Equatable, Codable {
    let id:Int
    let name:String
    let aboutMe: String?
    let profileImageURL: URL?
    let reputation: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case name = "display_name"
        case aboutMe = "about_me"
        case profileImageURL = "profile_image"
        case reputation
    }
}

struct Question: Codable {
    let id: Int
    let title: String
    let body: String?
    private (set) var score: Int
    let owner: User?
    
    enum CodingKeys: String, CodingKey {
        case id = "question_id"
        case title
        case body
        case score
        case owner
    }
    
    mutating func voteUp() {
        score += 1
    }
    
    mutating func voteDown() {
        score -= 1
    }
}

extension Question: Equatable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        return
            lhs.title == rhs.title &&
                lhs.body == rhs.body &&
                lhs.owner == rhs.owner
    }
}

struct Wrapper<ModelType: Decodable>: Decodable {
    let items: [ModelType]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}
