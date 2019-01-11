//
//  EditProfileViewController.swift
//  LifeHacksApp
//
//  Created by zombietux on 09/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import UIKit

protocol EditProfileViewControllerDelegate: class {
    func editProfileViewControllerDidEditProfileInfo(_ viewController: EditProfileViewController)
}

class EditProfileViewController: UIViewController, Stateful {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var aboutMeTextView: UITextView!
    
    var nameDidChange = false
    var aboutMeDidChange = false
    var stateController: StateController?
    weak var delegate: EditProfileViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = stateController?.user
        nameTextField.text = user?.name
        aboutMeTextView.text = user?.aboutMe
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, identifier == "Save" else {
            return
        }
        guard let stateController = stateController, let name = nameTextField.text, let aboutMe = aboutMeTextView.text else {
            return
        }
        let oldUser = stateController.user
        stateController.user = User(name: name, aboutMe: aboutMe, profileImage: oldUser.profileImage, reputation: oldUser.reputation)
        nameDidChange = name != oldUser.name
        aboutMeDidChange = aboutMe != oldUser.aboutMe
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == "Save" else {
            return true
        }
        guard nameTextField.text?.count == 0 || aboutMeTextView.text?.count == 0 else {
            return true
        }
        let title = "Missing name or about me"
        let message = "Both name and about me need to be present to be able to save your editing"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        return false
    }
}

