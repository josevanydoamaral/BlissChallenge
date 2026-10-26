//
//  UserStorageService.swift
//  
//
//  Created by Josevany on 24/10/2026.
//

import Foundation
import CoreData


final class UserStorageService: UserStorageServiceProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
    }
    
    func get() throws -> [User] {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        let entities = try context.fetch(request)
        
        var users: [User] = []
        
        for entity in entities {
            if let username = entity.username, let imageData = entity.imageData {
                let user = User(username: username, imageData: imageData)
                users.append(user)
            }
        }
        
        return users
    }
    
    func getUser(searchTerm: String) throws -> User? {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "username == %@", searchTerm)
        request.fetchLimit = 1
        
        guard let entity = try context.fetch(request).first,
              let username = entity.username,
              let imageData = entity.imageData else {
            return nil
        }
        
        return User(username: username, imageData: imageData)
    }
    
    func save(user: User) throws {
        let entity = UserEntity(context: context)
        entity.username = user.username
        entity.imageData = user.imageData
        
        if context.hasChanges {
            try context.save()
        }
    }
    
    func delete(user: User) throws {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "username == %@", user.username)
        request.fetchLimit = 1
        
        if let user = try context.fetch(request).first {
            context.delete(user)
            try context.save()
        }
    }
    
    
}
