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
    @IBOutlet weak var emailInputTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var currentEmailLabel: UILabel!
    @IBOutlet weak var loggedOutStackView: UIStackView!
    @IBOutlet weak var loggedInStackView: UIStackView!
    
    @IBAction func loginRegisterSegmentChanged(_ sender: UISegmentedControl) {
        loginButton.isHidden = sender.selectedSegmentIndex != loginSegmentIndex
        registerButton.isHidden = sender.selectedSegmentIndex == loginSegmentIndex
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        
    }
}
