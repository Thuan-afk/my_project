import Foundation
import UIKit
import SnapKit

class ProfileItemView: UIView {
    
    private lazy var iconViewImage: UIImageView = {
        let v = UIImageView()
        return v
    }()
    
    lazy var textTextField: UITextField = {
        let v = UITextField()
        v.isEnabled = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        updateViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(iconViewImage)
        self.addSubview(textTextField)
    }
    
    private func updateViewConstraints() {
        iconViewImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(30)
        }
        
        textTextField.snp.makeConstraints { make in
            make.left.equalTo(iconViewImage.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    func setIcon(icon: String) {
        iconViewImage.image = UIImage(systemName: icon)
    }
    
    func setTextLabel(text: String) {
        textTextField.text = text
    }
    
    func setEditView(isEdit: Bool) {
        textTextField.isEnabled = isEdit
    }
}
