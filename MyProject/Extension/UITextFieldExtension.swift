import Foundation
import UIKit

extension UITextField {
    func setPadding(left: CGFloat, right: CGFloat) {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
        self.leftView = leftView
        self.leftViewMode = .always
        self.rightView = rightView
        self.rightViewMode = .always
    }
}
