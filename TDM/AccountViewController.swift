//
//  AccountViewController.swift
//  TDM
//
//  Created by Aaron Lee on 2020/08/21.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import UIKit

private let loginSegmentIndex = 0

final class AccountViewController: UIViewController {
    var configurator = AccountConfiguratorImplementation()
    var presenter: AccountPresenter!
    
    @IBOutlet weak var emailInputTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var currentEmailLabel: UILabel!
    @IBOutlet weak var loggedOutStackView: UIStackView!
    @IBOutlet weak var loggedInStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(viewController: self)
//        presenter.viewDidLoad()
    }
    
    // MARK: - IBAction
    
    @IBAction func loginRegisterSegmentChanged(_ sender: UISegmentedControl) {
        loginButton.isHidden = sender.selectedSegmentIndex != loginSegmentIndex
        registerButton.isHidden = sender.selectedSegmentIndex == loginSegmentIndex
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if let email = emailInputTextField.text, let password = passwordTextField.text {
            presenter.loginPressed(email: email, password: password)
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        if let email = emailInputTextField.text, let password = passwordTextField.text {
            presenter.registerPressed(email: email, password: password)
        }
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        presenter.logoutPressed()
    }
}

// MARK: - AccountView

extension AccountViewController : AccountView {
    func displayLoggedIn(email: String) {
        currentEmailLabel.text = email
        loggedOutStackView.isHidden = true
        loggedInStackView.isHidden = false
    }
    
    func displayLoggedOut() {
        loggedOutStackView.isHidden = false
        loggedInStackView.isHidden = true
    }
    
    func displayError(msg: String) {
        presentAlert(withTitle: "Error", message: msg)
    }
}
