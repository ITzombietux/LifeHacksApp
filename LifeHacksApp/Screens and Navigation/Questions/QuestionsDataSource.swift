//
//  QuestionsDataSource.swift
//  LifeHacksApp
//
//  Created by zombietux on 11/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import UIKit

class QuestionsDataSource: NSObject {
    private let questions: [Question]
    
    init(questions: [Question]) {
        self.questions = questions
    }
    
    func question(at indexPath: IndexPath) -> Question {
        return questions[indexPath.row]
    }
}

extension QuestionsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuestionCell.self), for: indexPath) as! QuestionCell
        let question = self.question(at: indexPath)
        cell.score = question.score
        cell.title = question.title
        cell.username = question.owner?.name
        return cell
    }
}
