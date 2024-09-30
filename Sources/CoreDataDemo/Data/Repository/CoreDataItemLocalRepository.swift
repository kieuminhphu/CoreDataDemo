//
//  CoreDataItemLocalRepository.swift
//  CoreDataDemo
//
//  Created by Kieu Phu on 30/09/2024.
//

import Foundation
import CoreData

struct CoreDataItemLocalRepository: ItemLocalRepository {
    
    let context = PersistenceController.shared.container.viewContext
    
    func fetchItems() throws -> [Item] {
        let sortDescription = NSSortDescriptor(keyPath: \ItemEntity.timestamp, ascending: true)
        let fetchRequest: NSFetchRequest<ItemEntity> = ItemEntity.fetchRequest()
        fetchRequest.sortDescriptors = [sortDescription]
        
        let itemEntity = try context.fetch(fetchRequest)
        return itemEntity.map({ Item(id: $0.id ?? UUID(), timestamp: $0.timestamp) })
    }
    
    func addItem(_ item: Item) throws -> Item {
        let newItem = ItemEntity(context: context)
        newItem.id = item.id
        newItem.timestamp = item.timestamp
        
        try context.save()
        return item
    }
    
    func deleteItem(_ id: UUID) throws {
        let fetchRequest: NSFetchRequest<ItemEntity> = ItemEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        let itemEntity = try context.fetch(fetchRequest)
        if let deletedItem = itemEntity.first {
            context.delete(deletedItem)
            try context.save()
        }
    }
}
