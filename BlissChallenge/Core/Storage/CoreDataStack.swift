import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        self.persistentContainer = NSPersistentContainer(name: "BlissChallengeModel")
        
        persistentContainer.loadPersistentStores(completionHandler: { _, error in
            if let error {
                fatalError("Error initializing Core Data: \(error)")
            }
        })
    }
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}

