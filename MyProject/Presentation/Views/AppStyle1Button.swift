import Foundation
import UIKit

class AppStyle1Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setting()
    }
    
    private func setting() {
        self.setTitleColor(.greenMint1, for: .normal)
        self.backgroundColor = .greenMint2
        self.layer.cornerRadius = 8.0
    }
}
