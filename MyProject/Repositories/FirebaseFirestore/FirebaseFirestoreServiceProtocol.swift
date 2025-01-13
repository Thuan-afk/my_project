import Foundation
import RxSwift

protocol FirebaseFirestoreServiceProtocol {
//    func createUser(userId: String, userInfo: UserInfo) -> Observable<Void>
    func readUser(userId: String) -> Observable<UserInfo>
    func updateUser(userId: String, userInfo: UserInfo) -> Observable<Void>
//    func deleteUser(userId: String) -> Observable<Void> //Delete
//    func listenToUserChanges(userId: String) -> Observable<UserInfo>
}
