//
//  AddLocalItemUsecase.swift
//  CoreDataDemo
//
//  Created by Kieu Phu on 30/09/2024.
//

import Foundation

protocol AddLocalItemUsecase {
    func execute(_ item: Item) -> Result<Item, Error>
}

struct AddLocalItemUsecaseImpl: AddLocalItemUsecase {
    let repository: ItemLocalRepository
    
    func execute(_ item: Item) -> Result<Item, Error> {
        do {
            let item = try self.repository.addItem(item)
            return .success(item)
        } catch {
            return .failure(ItemError.addItemError)
        }
    }
}
