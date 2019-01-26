//
//  ApiController.swift
//  LifeHacksApp
//
//  Created by zombietux on 14/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import Foundation

class ApiController {
    struct StackExchangeAPI {
        static let questionsURL = URL(string: "https://api.stackexchange.com/2.2/questions")!
        static let usersURL = URL(string: "https://api.stackexchange.com/2.2/users")!
    }
    
    func loadQuestions(withCompletion completion: @escaping ([Question]?) -> Void) {
        let parameters = ["order": "desc", "sort": "activity", "site": "lifehacks", "pagesize": "10"]
        let url = StackExchangeAPI.questionsURL.appendingParameters(parameters)
        load(url: url) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            let wrapper = try? JSONDecoder().decode(Wrapper<Question>.self, from: data)
            completion(wrapper?.items)
        }
    }
    
    func loadQuestion(with id: Int, completion: @escaping (Question?) -> Void) {
        let parameters = ["filter": "withBody", "site": "lifehacks"]
        let url = StackExchangeAPI.questionsURL.appendingPathComponent("\(id)").appendingParameters(parameters)
        load(url: url) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            let wrapper = try? JSONDecoder().decode(Wrapper<Question>.self, from: data)
            completion(wrapper?.items[0])
        }
    }
    
    func loadUser(with id: Int, completion: @escaping (User?) -> Void) {
        let parameters = ["filter": "!9YdnSA078", "site": "lifehacks"]
        let url = StackExchangeAPI.questionsURL.appendingPathComponent("\(id)").appendingParameters(parameters)
        load(url: url) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            let wrapper = try? JSONDecoder().decode(Wrapper<User>.self, from: data)
            completion(wrapper?.items[0])
        }
    }
}

    private extension ApiController {
        func load(url: URL, withCompletion completion: @escaping (Data?) -> Void) {
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                completion(data)
            })
            task.resume()
        }
        
        enum Resource {
            case question(id: Int)
            case questions
            case user(id: Int)
        }

    func load(resource: Resource, withCompletion completion: @escaping (Any?) -> Void) {
        let url: URL
        switch resource {
        case .questions:
            let parameters = ["order": "desc", "sort": "activity", "pagesize": "10"]
            url = StackExchangeAPI.questionsURL.appendingParameters(parameters)
        case .question(let id):
            let parameters = ["filter": "withBody"]
            url = StackExchangeAPI.questionsURL.appendingPathComponent("\(id)").appendingParameters(parameters)
        case .user(let id):
            let parameters = ["filter": "!9YdnSA078"]
            url = StackExchangeAPI.questionsURL.appendingPathComponent("\(id)").appendingParameters(parameters)
        }
        load(url: url.appendingParameters(["site": "lifehacks"])) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            switch resource {
            case .questions:
                let wrapper = try? JSONDecoder().decode(Wrapper<Question>.self, from: data)
                completion(wrapper?.items)
            case .question:
                let wrapper = try? JSONDecoder().decode(Wrapper<Question>.self, from: data)
                completion(wrapper?.items[0])
            case .user:
                let wrapper = try? JSONDecoder().decode(Wrapper<User>.self, from: data)
                completion(wrapper?.items[0])
            }
        }
    }
}
