//
//  BubbleCellViewSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/20.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

@testable import SNS_Demo

class BubbleCellViewSpy: BubbleCellView {
    
    var displayedMessage = ""
    
    func display(message: String) {
        displayedMessage = message
    }
}
