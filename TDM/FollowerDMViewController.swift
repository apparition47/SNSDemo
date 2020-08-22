//
//  FollowerDMViewController.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/07.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

final class FollowerDMViewController: UIViewController, FollowerDMView {

    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: FollowerDMPresenter!
    var configurator: FollowerDMConfigurator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(followerDMViewController: self)
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    // MARK: - IBAction
    
    @IBAction func postButtonPressed(_ sender: Any) {
        presenter.postButtonPressed()
    }
    
    @IBAction func textInputEditingChanged(_ sender: UITextView) {
        if let text = sender.text {
            presenter.textInputEditingChanged(to: text)
        }
    }
    
    
    // MARK: - FollowerDMView
    
    func refreshFollowerDMView() {
        tableView.reloadData()
    }
    
    func displayFollowerDMRetrievalError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }
    
    func displayDMPostError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }
    
    func updateHeaderTitle(_ title: String) {
        self.title = title
    }
    
    func clearInput() {
        textInput.text = ""
        // manually trigger
        presenter.textInputEditingChanged(to: "")
    }
    
    func removePostCell(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - UITableViewDelegate
extension FollowerDMViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deletePost(row: indexPath.row)
        }
    }
}

// MARK: - UITableViewDataSource
extension FollowerDMViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfFollowerDM
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: presenter.cellReuseIdType(forRow: indexPath.row), for: indexPath) as! BubbleTableViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        
        return cell
    }
}
