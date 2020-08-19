//
//  FollowerTableViewCell.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/07.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

class FollowerTableViewCell: UITableViewCell, FollowerCellView {
    
    static let reuseableId = "FollowerTableViewCell"
    
    @IBOutlet weak var screenNameLabel: UILabel!
//    @IBOutlet weak var profileImageView: UIImageView!
    
    
    func display(screenName: String) {
        screenNameLabel.text = screenName
    }
    
}

