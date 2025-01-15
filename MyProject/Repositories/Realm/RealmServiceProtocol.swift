import Foundation
import RxSwift
import RealmSwift

protocol RealmServiceProtocol {
    func addBook(book: Book) -> Observable<Void>
    func getBooks() -> Observable<[Book]>
//    func updateBook() -> Observable<Book>
    func deleteBook(book: Book) -> Observable<Void>
}
