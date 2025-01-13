import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {
    
    private lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 16
        return v
    }()
    
    private lazy var emailLabel: UILabel = {
        let v = UILabel()
        v.text = "Email"
        return v
    }()
    
    private lazy var emailTextfield: BorderTextField = {
        let v = BorderTextField()
        return v
    }()
    
    private lazy var passwordLabel: UILabel = {
        let v = UILabel()
        v.text = "Password"
        return v
    }()
    
    private lazy var passwordTextfield: BorderTextField = {
        let v = BorderTextField()
        return v
    }()
    
    private lazy var loginButton: AppStyle1Button = {
        let v = AppStyle1Button()
        v.setTitle("Login", for: .normal)
        v.isEnabled = false
        return v
    }()
    
    private lazy var statusLabel: UILabel = {
        let v = UILabel()
        return v
    }()
    
    private let viewModel: LoginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupViews() {
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(emailTextfield)
        stackView.addArrangedSubview(passwordLabel)
        stackView.addArrangedSubview(passwordTextfield)
        stackView.addArrangedSubview(statusLabel)
        view.addSubview(stackView)
        view.addSubview(loginButton)
    }
    
    override func updateConstraints() {
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(36)
            make.right.equalToSuperview().offset(-36)
        }
        
        emailTextfield.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        
        passwordTextfield.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(220)
            make.height.equalTo(60)
        }
    }
    
    override func bindViewModel() {
        emailTextfield.rx.text.orEmpty
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)
        
        passwordTextfield.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind(to: viewModel.loginTapped)
            .disposed(by: disposeBag)
        
        viewModel.isLoginButtonEnabled
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.loginResult
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] user in
                self?.statusLabel.text = "Login Successful"
                UserDefaults.standard.set(user.uid, forKey: UserDefaultsKey.USER_ID)
                let vc = HomeViewController()
                vc.modalPresentationStyle = .overFullScreen
                self?.present(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.loginError
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.statusLabel.text = "Error: \(error)"
            })
            .disposed(by: disposeBag)
    }

}
