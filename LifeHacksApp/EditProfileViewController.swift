//
//  EditProfileViewController.swift
//  LifeHacksApp
//
//  Created by zombietux on 09/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var aboutMeTextView: UITextView!
    
    @IBAction func save(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
