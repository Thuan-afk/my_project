import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel {
    //input
    let name = BehaviorRelay<String>(value: "")
    let gender = BehaviorRelay<String>(value: "")
    let address = BehaviorRelay<String>(value: "")
    let updateTap = PublishRelay<Void>()
    
    //output
    let userInfo = BehaviorRelay<UserInfo?>(value: nil)
    let isEditing = BehaviorRelay<Bool>(value: false)
    let error = PublishRelay<String>()
    
    var isEditValue = false
    var userInfoValue: UserInfo? = nil
    
    let firebaseFirestoreService: FirebaseFirestoreServiceProtocol
    let disposeBag = DisposeBag()
    
    init(firebaseFirestoreService: FirebaseFirestoreServiceProtocol = FirebaseFirestoreService()) {
        self.firebaseFirestoreService = firebaseFirestoreService
        
        name.subscribe(
            onNext: { [weak self] name in
                self?.userInfoValue?.update(name: name)
            }
        )
        .disposed(by: disposeBag)
        
        gender.subscribe(
            onNext: { [weak self] gender in
                self?.userInfoValue?.update(gender: gender)
            }
        )
        .disposed(by: disposeBag)
        
        address.subscribe(
            onNext: { [weak self] address in
                self?.userInfoValue?.update(address: address)
            }
        )
        .disposed(by: disposeBag)
        
        updateTap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if (self.isEditValue) {
                self.updateUserInfo()
            } else {
                self.isEditValue = true
                self.isEditing.accept(self.isEditValue)
            }
        })
        .disposed(by: disposeBag)
    }
    
    func getUserInfo() {
        guard let userId = UserDefaults.standard.string(forKey: UserDefaultsKey.USER_ID) else { return }
        firebaseFirestoreService.readUser(userId: userId)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] userInfo in
                    self?.userInfoValue = userInfo
                    self?.userInfo.accept(userInfo)
                },
                onError: { [weak self] error in
                    self?.error.accept(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func updateUserInfo() {
        guard let userId = UserDefaults.standard.string(forKey: UserDefaultsKey.USER_ID), let userInfoValue = userInfoValue else { return }
        firebaseFirestoreService.updateUser(userId: userId, userInfo: userInfoValue)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] in
                    guard let self = self else { return }
                    self.isEditValue = false
                    self.isEditing.accept(self.isEditValue)
                },
                onError: { [weak self] error in
                    self?.error.accept(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
}
