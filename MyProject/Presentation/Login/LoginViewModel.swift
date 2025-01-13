import Foundation
import RxCocoa
import RxSwift
import FirebaseAuth

class LoginViewModel {
    //input
    let username = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let loginTapped = PublishRelay<Void>()
    
    //output
    let isLoginButtonEnabled: Observable<Bool>
    let loginResult = PublishRelay<User>()
    let loginError = PublishRelay<String>()
    
    private let firebaseAuthService: FirebaseAuthServiceProtocol
    private let apiService: APIService = APIService()
    private let disposeBag = DisposeBag()
    
    init(firebaseAuthService: FirebaseAuthServiceProtocol = FirebaseAuthService()) {
        self.firebaseAuthService = firebaseAuthService
        
        isLoginButtonEnabled = Observable.combineLatest(username, password) { username, password in
            return !username.isEmpty && !password.isEmpty
        }
        
        loginTapped
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.loginWithEmail(email: self.username.value, password: self.password.value)
            })
            .disposed(by: disposeBag)
    }
    
    func loginWithEmail(email: String, password: String) {
        firebaseAuthService.login(email: email, password: password)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] user in
                    self?.loginResult.accept(user)
                },
                onError: { [weak self] error in
                    self?.loginError.accept(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
}
 
//        loginTapped
//            .withLatestFrom(Observable.combineLatest(username, password))
//            .flatMapLatest { [weak self] username, password -> Observable<LoginResponse> in
//                guard let self = self else { return Observable.empty() }
//                return self.apiService.login(username: username, password: password)
//                    .catch { error in
//                        self.loginError.accept(error.localizedDescription)
//                        return Observable.empty()
//                    }
//            }
//            .bind(to: loginResult)
//            .disposed(by: disposeBag)
