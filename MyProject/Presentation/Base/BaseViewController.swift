import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        updateConstraints()
        bindViewModel()
    }
    
    func setupViews() {}
    func updateConstraints() {}
    func bindViewModel() {}

}
