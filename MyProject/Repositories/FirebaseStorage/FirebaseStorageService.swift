import Foundation
import RxSwift
import FirebaseStorage

class FirebaseStorageService: FirebaseStorageServiceProtocol {
    func uploadImage(_ image: UIImage) -> Observable<String> {
        Observable.create{ observer in
            let imageData = image.jpegData(compressionQuality: 0.8) ?? Data()
            let storageRef = Storage.storage().reference().child("images/\(UUID().uuidString).jpg")
            
            storageRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    observer.onError(error)
                }
                else {
                    storageRef.downloadURL { url, error in
                        if let error = error {
                            observer.onError(error)
                            observer.onCompleted()
                        } else if let downloadURL = url {
                            observer.onNext(downloadURL.absoluteString)
                        }
                    }
                }
            }
            return Disposables.create()
        }
    }

    func downloadImage(from url: String) -> Observable<UIImage> {
        Observable.create{ observer in
            let storageRef = Storage.storage().reference(forURL: url)
            storageRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                if let error = error {
                    observer.onError(error)
                } else if let data = data, let image = UIImage(data: data) {
                    observer.onNext(image)
                }
            }
            return Disposables.create()
        }
    }
}
