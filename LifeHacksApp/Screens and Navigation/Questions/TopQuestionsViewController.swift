//
//  TopQuestionsViewController.swift
//  LifeHacksApp
//
//  Created by zombietux on 10/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import UIKit

class TopQuestionsViewController: UIViewController, UITableViewDelegate, Stateful {
    
    @IBOutlet weak var tableView: UITableView!
    var questionsDataSource: QuestionsDataSource?
    var stateController: StateController?
    var settingsController: SettingsController?

    override func viewWillAppear(_ animated: Bool) {
        guard let topQuestions = stateController?.topQuestions else {
            return
        }
        questionsDataSource = QuestionsDataSource(questions: topQuestions)
        tableView.dataSource = questionsDataSource
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let questionViewController = segue.destination as? QuestionViewController else {
            return
        }
        passState(to: questionViewController)
        if let indexPath = tableView.indexPathForSelectedRow {
            questionViewController.question = questionsDataSource?.question(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? QuestionCell,
            let scheme = settingsController?.scheme {
            cell.titleColor = scheme.titleColor
        }
    }
}
