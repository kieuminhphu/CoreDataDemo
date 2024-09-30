//
//  FetchItemsUsecase.swift
//  CoreDataDemo
//
//  Created by Kieu Phu on 30/09/2024.
//

import Foundation

protocol FetchLocalItemsUsecase {
    func execute() -> Result<[Item], Error>
}

struct FetchLocalItemsUsecaseImpl: FetchLocalItemsUsecase {
    
    let repository: ItemLocalRepository
    
    func execute() -> Result<[Item], Error> {
        do {
            let items = try repository.fetchItems()
            return .success(items)
        } catch {
            return .failure(ItemError.fetchError)
        }
    }
}
