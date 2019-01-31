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
    var uploadNotificationCenter: NotificationCenter?
    
    private var request: ApiRequest<QuestionsResource>?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let cachedQuestions = stateController?.topQuestions {
            updateDataSource(withQuestions: cachedQuestions)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchTopQuestions()
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

private extension TopQuestionsViewController {
    func updateDataSource(withQuestions questions: [Question]) {
        questionsDataSource = QuestionsDataSource(questions: questions)
        tableView.dataSource = questionsDataSource
        tableView.reloadData()
    }
    
    func fetchTopQuestions() {
        let resource = QuestionsResource(id: nil)
        self.request = ApiRequest(resource: resource)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        request?.execute { [weak self] result in
            guard let questions = result else {
                return
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self?.stateController?.topQuestions = questions
            self?.request = nil
            self?.updateDataSource(withQuestions: questions)
        }
    }
}

