//
//  FollowerDMViewSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/21.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

@testable import SNS_Demo

class FollowerDMViewSpy: FollowerDMView {

    var refreshFollowerDMListCalled = false
    var clearInputCalled = false
    var removedPostRow: Int?
    var displayHeaderTitle: String?
    var displayErrorTitle: String?
    var displayErrorMessage: String?
    
    func refreshFollowerDMView() {
        refreshFollowerDMListCalled = true
    }
    
    func displayCurrencyListError(title: String, message: String) {
        displayErrorTitle = title
        displayErrorMessage = message
    }
    
    func displayFollowerDMRetrievalError(title: String, message: String) {
        displayErrorTitle = title
        displayErrorMessage = message
    }
    
    func displayDMPostError(title: String, message: String) {
        displayErrorTitle = title
        displayErrorMessage = message
    }
    
    func updateHeaderTitle(_ title: String) {
        displayHeaderTitle = title
    }
    
    func clearInput() {
        clearInputCalled = true
    }
    
    func removePostCell(row: Int) {
        removedPostRow = row
    }
    
}
