//
//  BaseViewController.swift
//  MyProject
//
//  Created by AnySES on 10/1/25.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        updateConstraints()
    }
    
    func setupViews() {}
    func updateConstraints() {}

}
