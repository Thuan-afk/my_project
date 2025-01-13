import Foundation
import RxSwift
import FirebaseAuth

protocol FirebaseAuthServiceProtocol {
    func login(email: String, password: String) -> Observable<User>
    func logout() -> Observable<Void>
}
