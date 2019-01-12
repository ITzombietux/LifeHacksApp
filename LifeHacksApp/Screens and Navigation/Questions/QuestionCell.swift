//
//  QuestionCell.swift
//  LifeHacksApp
//
//  Created by zombietux on 11/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ownerLabel: UILabel!
    
    var score: Int? {
        didSet {
            scoreLabel.text = "\(score ?? 0)"
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var username: String? {
        didSet {
            ownerLabel.text = "Asked by: " + (username ?? "")
        }
    }
    
    var titleColor: UIColor? {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
}
