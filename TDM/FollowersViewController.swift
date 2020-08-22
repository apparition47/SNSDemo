//
//  LoginViewController.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

final class FollowersViewController: UITableViewController {
    var configurator = FollowersConfiguratorImplementation()
    var presenter: FollowersPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(followersViewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    // MARK: - IBAction
    
    @IBAction func myTimelineTapped(_ sender: Any) {
        presenter.didSelectMyTimeline()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfFollowers
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FollowerTableViewCell.reuseableId, for: indexPath) as! FollowerTableViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
}

// MARK: - FollowersView

extension FollowersViewController : FollowersView {

    
    func refreshFollowersView() {
        tableView.reloadData()
        
    }
    
    func displayFollowersRetrievalError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }
    
    func updateBackground(hexColour: String) {
        
    }
    
    
}
