import Foundation
import RxSwift
import FirebaseFirestore

class FirebaseFirestoreService: FirebaseFirestoreServiceProtocol {

    func readUser(userId: String) -> Observable<UserInfo> {
        return Observable.create { observer in
            let db = Firestore.firestore()
            db.collection("Users").document(userId).getDocument { (document, error) in
                if let error = error {
                    observer.onError(error)
                } else if let document = document, document.exists {
                    if let userData = document.data() {
                        if let userInfo = UserInfo(dictionary: userData) {
                            observer.onNext(userInfo)
                        }
                        observer.onCompleted()
                    } else {
                        observer.onError(NSError(domain: "DataError", code: -1, userInfo: nil))
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func updateUser(userId: String, userInfo: UserInfo) -> Observable<Void> {
        return Observable.create { observer in
            do {
                let userInfoDictionary = try userInfo.toDictionary()
                let db = Firestore.firestore()
                db.collection("Users").document(userId).updateData(userInfoDictionary) { error in
                    observer.onNext(())
                    observer.onCompleted()
                }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

}
