import Foundation
import RealmSwift

class Book: Object {
    @Persisted var id: ObjectId = ObjectId.generate()
    @Persisted var name: String = ""
    @Persisted var author: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
