//
//  Resources.swift
//  LifeHacksApp
//
//  Created by zombietux on 30/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import Foundation

protocol ApiResource {
    associatedtype ModelType: Decodable
    var id: Int? { get }
    var path: String { get }
    var filter: String { get }
}

extension ApiResource {
    var url: URL {
        let baseUrl = URL(string: "https://api.stackexchange.com/2.2")!
        var url = baseUrl.appendingPathComponent(path)
        if let id = id {
            url.appendPathComponent("\(id)")
            url = url.appendingParameters(["filter": filter])
        } else {
            url = url.appendingParameters(["order": "desc", "sort": "votes", "pagesize": "10"])
        }
        return url.appendingParameters(["site": "lifehacks"])
    }
}

struct UsersResource: ApiResource {
    typealias ModelType = User
    let id: Int?
    let path = "/users"
    let filter = "!9YdnSA078"
}

struct QuestionsResource: ApiResource {
    typealias ModelType = Question
    let id: Int?
    let path = "/questions"
    let filter = "withBody"
}
