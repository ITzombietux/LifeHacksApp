//
//  ProfileViewController.swift
//  LifeHacksApp
//
//  Created by zombietux on 09/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Stateful {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var aboutMeLabel: UILabel!
    @IBOutlet weak var changeProfilePictureButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    var user: User?
    var stateController: StateController?
    var settingsController: SettingsController?
    var uploadNotificationCenter: NotificationCenter?
    
    private var userRequest: ApiRequest<UsersResource>?
    private var uploadRequest: ApiRequest<UsersResource>?
    private var avatarRequest: ImageRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadNotificationCenter?.addObserver(forName: UploadNotification.completed.name, object: nil, queue: .main) { [weak self] _ in
            self?.changeProfilePictureButton.isEnabled = true
            self?.activityIndicator.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user = self.user {
            set(user)
            navigationItem.rightBarButtonItem = nil
            fetchRemoteData(for: user)
        } else if let user = stateController?.user {
            set(user)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController else {
            return
        }
        let destination = navigationController.viewControllers.first
        if let destination = destination as? Stateful {
            passState(to: destination)
        }
        if let destination = destination as? EditProfileViewController {
            destination.delegate = self
        }
    }
    
    @IBAction func editWasSaved(_ segue: UIStoryboardSegue) {
        guard let editViewController = segue.source as? EditProfileViewController else {
            return
        }
        if editViewController.nameDidChange {
            nameLabel.textColor = UIColor.orange
        }
        if editViewController.aboutMeDidChange {
            aboutMeLabel.textColor = UIColor.orange
        }
    }
    
    @IBAction func editWasCanceled(_ segue: UIStoryboardSegue) {}
    
    @IBAction func uploadProfilePicture(_ sender: AnyObject) {
        guard let user = stateController?.user,
            let uploadNotificationCenter = uploadNotificationCenter else {
                return
        }
        changeProfilePictureButton.isEnabled = false
        activityIndicator.startAnimating()
        let eesource = UsersResource(id: user.id)
        let request = ApiRequest(resource: eesource)
        self.uploadRequest = request
        request.fakeUpload(notifyingOn: uploadNotificationCenter)
    }
}

extension ProfileViewController: EditProfileViewControllerDelegate {
    func editProfileViewControllerDidEditProfileInfo(_ viewController: EditProfileViewController) {
        nameLabel.textColor = UIColor.orange
        reputationLabel.textColor = UIColor.orange
        aboutMeLabel.textColor = UIColor.orange
    }
}

private extension ProfileViewController {
    func set(_ user: User) {
        nameLabel.text = user.name
        reputationLabel.text = user.reputation != nil ? "\(user.reputation!)" : ""
        aboutMeLabel.attributedText = user.aboutMe?.htmlString
}

    func fetchRemoteData(for user: User) {
        let resource = UsersResource(id: user.id)
        let request = ApiRequest(resource: resource)
        self.userRequest = request
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        request.execute { [weak self] users in
            guard let user = users?.first else {
                return
            }
            self?.set(user)
            guard let imageUrl = user.profileImageURL else {
                return
            }
            let imageRequest = ImageRequest(url: imageUrl)
            self?.avatarRequest = imageRequest
            imageRequest.execute(withCompletion: { (image) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self?.profilePictureImageView.image = image
            })
        }
    }
}
