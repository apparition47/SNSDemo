//
//  BubbleTableViewCell.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

final class BubbleTableViewCell: UITableViewCell, BubbleCellView {
	
    static let leftReuseableId = "LeftBubbleTableViewCell"
    static let rightReuseableId = "RightBubbleTableViewCell"
    
	@IBOutlet weak var messageTextView: UITextView!
	
	func display(message: String) {
		messageTextView.text = message
	}
	
}
