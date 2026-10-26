import Foundation
import CoreData

final class EmojiStorageService: EmojiStorageServiceProtocol {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
    }
    
    func save(emojis: EmojisDictionary) throws {
        for (name, urlString) in emojis {
            let entity = EmojiEntity(context: context)
            entity.name = name
            entity.urlString = urlString
        }
        
        if context.hasChanges {
            try context.save()
        }
    }
    
    func get() throws -> EmojisDictionary {
        let request:NSFetchRequest<EmojiEntity> = EmojiEntity.fetchRequest()
        
        let entities = try context.fetch(request)
        
        var emojis: EmojisDictionary = [:]
        
        for entity in entities {
            if let name = entity.name, let urlString = entity.urlString {
                emojis[name] = urlString
            }
        }
        
        return emojis
    }
}
