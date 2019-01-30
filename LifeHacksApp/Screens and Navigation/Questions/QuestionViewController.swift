//
//  ViewController.swift
//  LifeHacksApp
//
//  Created by zombietux on 01/12/2018.
//  Copyright © 2018 zombietux. All rights reserved.
//

import UIKit

class QuestionViewController: UITableViewController, Stateful {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    var stateController: StateController?
    var question: Question?
    var settingsController: SettingsController?
    
    private var questionRequest: ApiRequest<QuestionsResource>?
    private var avatarRequest: ImageRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let question = question else {
            return
        }
        titleLabel.text = question.title.htmlString?.string
        bodyLabel.text = question.body
        updateScore(for: question)
        let owner = question.owner
        ownerNameLabel.text = owner?.name
        fetchRemoteData(for: question)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let profileViewController = segue.destination as? ProfileViewController {
            passState(to: profileViewController)
            profileViewController.user = question?.owner
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let scheme = settingsController?.scheme else {
            return
        }
        titleLabel.textColor = scheme.titleColor
        for button in buttons {
            button.tintColor = scheme.buttonColor
        }
    }
    
    @IBAction func voteUp(_ sender: AnyObject) {
        question?.voteUp()
        updateScore(for: question)
        updateState(for: question)
    }
    
    @IBAction func voteDown(_ sender: AnyObject) {
        question?.voteDown()
        updateScore(for: question)
        updateState(for: question)
    }
}

private extension QuestionViewController {
    func updateState(for question: Question?) {
        if let question = question {
            stateController?.updateQuestion(question)
        }
    }
    
    func updateScore(for question: Question?) {
        scoreLabel.text = "\(question?.score ?? 0)"
    }
    
    func fetchRemoteData(for question: Question) {
        let resource = QuestionsResource(id: question.id)
        let request = ApiRequest(resource: resource)
        self.questionRequest = request
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        request.execute { [weak self] result in
            guard let question = result?.first else {
                return
            }
            self?.bodyLabel.attributedText = question.body?.htmlString
            self?.tableView.reloadData()
            guard let imageUrl = question.owner?.profileImageURL else {
                return
            }
            let imageRequest = ImageRequest(url: imageUrl)
            self?.avatarRequest = imageRequest
            imageRequest.execute { image in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self?.ownerImageView.image = image
            }
        }
    }
}


