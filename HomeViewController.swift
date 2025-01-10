//
//  HomeViewController.swift
//  MyProject
//
//  Created by AnySES on 10/1/25.
//

import Foundation
import UIKit

class HomeViewController: BaseViewController {
    
    private lazy var label: UILabel = {
        let v = UILabel()
        v.text = "Home"
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupViews() {
        view.addSubview(label)
    }
    
    override func updateConstraints() {
    }

}
