import Foundation
import RxSwift
import FirebaseAuth

class FirebaseAuthService: FirebaseAuthServiceProtocol {

    func login(email: String, password: String) -> Observable<User> {
        return Observable.create { observer in
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let error = error {
                    observer.onError(error)
                } else if let user = authResult?.user {
                    observer.onNext(user)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    func logout() -> Observable<Void> {
        return Observable.create { observer in
            do {
                try Auth.auth().signOut()
                observer.onNext(())
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

}
