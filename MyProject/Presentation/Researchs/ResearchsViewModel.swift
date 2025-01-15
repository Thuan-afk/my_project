import Foundation
import RxSwift
import RxCocoa

enum Researchs: String {
    case realm = "Realm"
}

class ResearchsViewModel {
    
    //output
    let researchs = BehaviorRelay<[Researchs]>(value: [])
    
    init() {
    }
    
    func researchsInit() {
        let researchsTerm: [Researchs] = [.realm]
        researchs.accept(researchsTerm)
    }
}
