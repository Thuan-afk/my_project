import Foundation
import RxSwift
import RxCocoa

class RealmViewModel {
    //input
    let name = BehaviorRelay<String>(value: "")
    let author = BehaviorRelay<String>(value: "")
    let addTap = PublishRelay<Void>()
    
    //output
    let books = BehaviorRelay<[Book]>(value: [])
    let error = PublishRelay<String>()
    
    private let realmService: RealmServiceProtocol
    private let disposeBag = DisposeBag()
    
    init(realmService: RealmServiceProtocol = RealmService()) {
        self.realmService = realmService
        
        addTap.subscribe(
            onNext: { [weak self] in
                self?.addBook()
            }
        )
        .disposed(by: disposeBag)
    }
    
    func getBooks() {
        realmService.getBooks()
            .subscribe(
                onNext: { [weak self] books in
                    guard let self = self else { return }
                    self.books.accept(books)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func addBook() {
        let book = Book()
        book.name = name.value
        book.author = author.value
        realmService.addBook(book: book)
            .subscribe(
                onNext: { [weak self] in
                    guard let self = self else { return }
                    var books = books.value
                    books.append(book)
                    self.books.accept(books)
                    self.name.accept("")
                    self.author.accept("")
                },
                onError: { [weak self] error in
                    self?.error.accept(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func deleteBook(book: Book) {
        realmService.deleteBook(book: book)
            .subscribe(
                onNext: { [weak self] in
                    guard let self = self else { return }
                    var books = books.value
                    for index in stride(from: books.count - 1, through: 0, by: -1) {
                        if books[index] == book.id {
                            books.remove(at: index)
                        }
                    }
                    self.books.accept(books)
                }
            )
            .disposed(by: disposeBag)
    }
}
