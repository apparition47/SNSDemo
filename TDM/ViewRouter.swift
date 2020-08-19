//
//  ViewRouter.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

protocol ViewRouter {
	func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

extension ViewRouter {
	func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
}
