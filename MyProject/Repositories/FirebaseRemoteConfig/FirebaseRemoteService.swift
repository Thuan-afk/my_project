import Foundation
import Firebase
import FirebaseRemoteConfig

class FirebaseRemoteService {

    private let remoteConfig: RemoteConfig
    
    init() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        let defaultValues = ["profileColor": "pink" as NSObject]
        remoteConfig.setDefaults(defaultValues)
    }
    
    func fetchRemoteConfig(completion: @escaping (Bool) -> Void) {
        remoteConfig.fetch { [weak self] status, error in
            guard let self = self else { return }
            if status == .success {
                self.remoteConfig.activate { _, _ in
                    completion(self.remoteConfig.configValue(forKey: "find_a_job").boolValue)
                }
            } else {
                completion(false)
            }
        }
    }
    
}
