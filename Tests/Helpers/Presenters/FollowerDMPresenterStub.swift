//
//  FollowerDMPresenterStub.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/20.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

@testable import SNS_Demo

class FollowerDMPresenterStub: FollowerDMPresenter {

    var numberOfFollowerDM: Int {
        0
    }
    
    var router: FollowerDMViewRouter
    
    init (router: FollowerDMViewRouter) {
        self.router = router
    }
    
    // TODO create spy
    
    func viewDidLoad() {
        
    }
    
    func configure(cell: BubbleCellView, forRow row: Int) {
        
    }
    
    func cellReuseIdType(forRow row: Int) -> String {
        return ""
    }
    
    func textInputEditingChanged(to: String) {
        
    }
    
    func postButtonPressed() {
        
    }
    
    func deletePost(row: Int) {
        
    }
}
