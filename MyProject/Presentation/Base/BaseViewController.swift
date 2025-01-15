import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        updateConstraints()
        bindViewModel()
    }
    
    func setupViews() {}
    func updateConstraints() {}
    func bindViewModel() {}

}
