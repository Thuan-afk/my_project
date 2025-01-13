import Foundation
import RxSwift

class LoginResponse: Decodable {
}

class APIService {
    func login(username: String, password: String) -> Observable<LoginResponse> {
        let url = URL(string: "https://api.example.com/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "username": username,
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NSError(domain: "NoData", code: -1, userInfo: nil))
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    observer.onNext(decodedResponse)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}
