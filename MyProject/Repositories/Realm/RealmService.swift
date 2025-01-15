import Foundation
import RxSwift
import RealmSwift

class RealmService: RealmServiceProtocol {
    private let realm = try! Realm()
    
    func addBook(book: Book) -> Observable<Void> {
        Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(NSError(domain: "RealmError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Self is nil"]))
                return Disposables.create()
            }

            do {
                try self.realm.write {
                    self.realm.add(book)
                }
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func getBooks() -> Observable<[Book]> {
        Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(NSError(domain: "RealmError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Self is nil"]))
                return Disposables.create()
            }
            
            let books = Array(self.realm.objects(Book.self))
            observer.onNext(books)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func deleteBook(book: Book) -> Observable<Void> {
        Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(NSError(domain: "RealmError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Self is nil"]))
                return Disposables.create()
            }
            
            do {
                try self.realm.write {
                    self.realm.delete(book)
                }
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
