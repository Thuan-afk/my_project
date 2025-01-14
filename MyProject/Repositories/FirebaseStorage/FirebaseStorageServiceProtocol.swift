import Foundation
import UIKit
import RxSwift

protocol FirebaseStorageServiceProtocol {
    func uploadImage(_ image: UIImage) -> Observable<String>
    func downloadImage(from url: String) -> Observable<UIImage>
}

