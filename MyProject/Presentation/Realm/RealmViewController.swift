import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RealmViewController: BaseViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(RealmTableViewCell.self, forCellReuseIdentifier: RealmTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var nameTextField: BorderTextField = {
        let textField = BorderTextField()
        textField.placeholder = "Book name"
        return textField
    }()
    
    private lazy var authorTextField: BorderTextField = {
        let textField = BorderTextField()
        textField.placeholder = "Authen name"
        return textField
    }()
    
    private lazy var addButton: AppStyle1Button = {
        let button = AppStyle1Button()
        button.setTitle("Add", for: .normal)
        return button
    }()
    
    private let viewModel = RealmViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Realm"
        
        viewModel.getBooks()
    }
    
    override func setupViews() {
        view.addSubview(tableView)
        view.addSubview(bottomView)
        bottomView.addSubview(nameTextField)
        bottomView.addSubview(authorTextField)
        bottomView.addSubview(addButton)
    }
    
    override func updateConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(30)
        }
        
        authorTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(30)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(authorTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    override func bindViewModel() {
        nameTextField.rx.text.orEmpty
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)
        
        authorTextField.rx.text.orEmpty
            .bind(to: viewModel.author)
            .disposed(by: disposeBag)
        
        addButton.rx.tap
            .bind(to: viewModel.addTap)
            .disposed(by: disposeBag)
        
        viewModel.name
            .bind(to: nameTextField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.author
            .bind(to: authorTextField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.books
            .subscribe(
                onNext: { [weak self] _ in
                    self?.tableView.reloadData()
                }
            )
            .disposed(by: disposeBag)
    }
}

extension RealmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.books.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RealmTableViewCell.reuseIdentifier, for: indexPath) as? RealmTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(book: viewModel.books.value[indexPath.row], deleteAction: { [weak self] book in
            guard let self = self else { return }
            self.viewModel.deleteBook(book: self.viewModel.books.value[indexPath.row])
        })
        return cell
    }
}
