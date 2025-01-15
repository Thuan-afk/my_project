//
//  BorderTextField.swift
//  MyProject
//
//  Created by AnySES on 10/1/25.
//

import Foundation
import UIKit

class BorderTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setting()
    }
    
    private func setting() {
        self.layer.borderColor = UIColor.greenMint4.cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        self.setPadding(left: 10, right: 10)
    }
}
