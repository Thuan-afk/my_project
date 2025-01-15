import Foundation
import UIKit
import SnapKit

class ResearchTableViewCell: BaseTableViewCell {
    
    static let reuseIdentifier = String(describing: ResearchTableViewCell.self)
    
    private lazy var nameLabel: UILabel = {
        let v = UILabel()
        return v
    }()
    
    override func setupViews() {
        self.addSubview(nameLabel)
    }
    
    override func updateViewConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func setName(name: String) {
        nameLabel.text = name
    }
}
