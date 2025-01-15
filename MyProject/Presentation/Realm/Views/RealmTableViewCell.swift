import Foundation
import UIKit
import SnapKit

class RealmTableViewCell: BaseTableViewCell {
    
    static let reuseIdentifier = String(describing: RealmTableViewCell.self)
        
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash.square")?.withTintColor(.red), for: .normal)
        button.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        return button
    }()
    
    private var book: Book? = nil
    var delete: ((Book) -> Void)?
    
    override func setupViews() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(deleteButton)
    }
    
    override func updateViewConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-50)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.right.equalToSuperview().offset(-50)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(30)
        }
    }
    
    func configure(book: Book, deleteAction: @escaping (Book) -> Void) {
        self.book = book
        self.delete = deleteAction
        nameLabel.text = "Book: \(book.name)"
        authorLabel.text = "Author: \(book.author)"
    }
    
    @objc private func handleDelete() {
        guard let book = book else { return }
        delete?(book)
    }
}
