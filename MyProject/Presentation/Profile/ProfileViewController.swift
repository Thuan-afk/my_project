import Foundation
import UIKit
import FirebaseFirestore
import RxSwift

class ProfileViewController: BaseViewController {
    
    private lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 16
        return v
    }()
    
    private lazy var nameItemView: ProfileItemView = {
        let v = ProfileItemView()
        v.setIcon(icon: "person.crop.circle")
        return v
    }()
    
    private lazy var genderItemView: ProfileItemView = {
        let v = ProfileItemView()
        v.setIcon(icon: "person.fill.questionmark")
        return v
    }()
    
    private lazy var addressItemView: ProfileItemView = {
        let v = ProfileItemView()
        v.setIcon(icon: "house")
        return v
    }()
    
    private lazy var findAJobItemView: ProfileItemView = {
        let v = ProfileItemView()
        v.setIcon(icon: "sparkle.magnifyingglass")
        v.setTextLabel(text: "Find a job")
        v.isHidden = true
        return v
    }()
    
    private lazy var editButton: AppStyle1Button = {
        let v = AppStyle1Button()
        v.setTitle("Update", for: .normal)
        return v
    }()
    
    private let viewModel = ProfileViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchConfig()
        viewModel.getUserInfo()
    }
    
    override func setupViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(nameItemView)
        stackView.addArrangedSubview(genderItemView)
        stackView.addArrangedSubview(addressItemView)
        stackView.addArrangedSubview(findAJobItemView)
        view.addSubview(editButton)
    }
    
    override func updateConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.right.equalToSuperview()
        }
        
        nameItemView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        genderItemView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        addressItemView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        findAJobItemView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        editButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-120)
            make.centerX.equalToSuperview()
            make.width.equalTo(220)
            make.height.equalTo(60)
        }
    }
    
    override func bindViewModel() {
        nameItemView.textTextField.rx.text.orEmpty
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)
        
        genderItemView.textTextField.rx.text.orEmpty
            .bind(to: viewModel.gender)
            .disposed(by: disposeBag)
        
        addressItemView.textTextField.rx.text.orEmpty
            .bind(to: viewModel.address)
            .disposed(by: disposeBag)
        
        editButton.rx.tap
            .bind(to: viewModel.updateTap)
            .disposed(by: disposeBag)
        
        viewModel.findAJob
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] findAJob in
                self?.findAJobItemView.isHidden = !findAJob
            })
            .disposed(by: disposeBag)
        
        viewModel.isEditing
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isEditing in
                self?.nameItemView.textTextField.isEnabled = isEditing
                self?.genderItemView.textTextField.isEnabled = isEditing
                self?.addressItemView.textTextField.isEnabled = isEditing
                if(isEditing) {
                    self?.editButton.setTitle("Save", for: .normal)
                } else {
                    self?.editButton.setTitle("Update", for: .normal)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.userInfo
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] userInfo in
                guard let self = self, let userInfo = userInfo else { return }
                self.nameItemView.setTextLabel(text: userInfo.name)
                self.genderItemView.setTextLabel(text: userInfo.gender)
                self.addressItemView.setTextLabel(text: userInfo.address)
                }
            )
            .disposed(by: disposeBag)
    }
    
}
