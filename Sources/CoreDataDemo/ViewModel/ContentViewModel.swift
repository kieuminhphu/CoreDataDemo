//
//  ContentViewModel.swift
//  CoreDataDemo
//
//  Created by Kieu Phu on 30/09/2024.
//

import Foundation
import Combine
import Factory

class ContentViewModel: ObservableObject {
    
    let fetchLocalItemsUsecase: FetchLocalItemsUsecase = Container.shared.fetchLocalItemsUsecase.resolve()
    let addLocalItemUsecase: AddLocalItemUsecase = Container.shared.addLocalItemUsecase.resolve()
    let deleteLocalItemUsecase: DeleteLocalItemUsecase = Container.shared.deleteLocalItemUsecase.resolve()
    
    @Published var items: [ItemViewModel] = []
    
    init() {
        loadItems()
    }
    
    func loadItems() {
        let result = fetchLocalItemsUsecase.execute()
        switch result {
        case .success(let items):
            self.items = items.map( { ItemViewModel(id: $0.id, timestamp: itemFormatter.string(from: $0.timestamp!) )})
        case .failure(let error):
            print("Failed to load items \(error)")
        }
    }
    
    func addItem(_ timestamp: Date) {
        let addItem = Item(timestamp: timestamp)
        let result = addLocalItemUsecase.execute(addItem)
        switch result {
        case .success(let item):
            items.append(ItemViewModel(id: item.id, timestamp: itemFormatter.string(from: item.timestamp!)))
            
        case .failure(let error):
            print("Failed to add item \(error)")
        }
    }
    
    func deleteItem(_ id: UUID) {
        let result = deleteLocalItemUsecase.execute(id)
        switch result {
        case .success:
            self.items.removeAll(where: {$0.id == id })
        case .failure(let error):
            print("Failed to delete item \(error)")
        }
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}
