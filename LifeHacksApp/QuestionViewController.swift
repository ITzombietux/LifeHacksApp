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
    
    var stateController: StateController?
    var question: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let question = question else {
            return
        }
        titleLabel.text = question.title
        bodyLabel.text = question.body
        updateScore(for: question)
        let owner = question.owner
        ownerImageView.image = UIImage(named: owner.profileImage)
        ownerNameLabel.text = owner.name
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
}


