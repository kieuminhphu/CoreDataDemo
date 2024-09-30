//
//  DeleteLocalItemUsecase.swift
//  CoreDataDemo
//
//  Created by Kieu Phu on 30/09/2024.
//

import Foundation

protocol DeleteLocalItemUsecase {
    func execute(_ id: UUID) -> Result<Void, Error>
}

struct DeleteLocalItemUsecaseImpl: DeleteLocalItemUsecase {
    let repository: ItemLocalRepository
    
    func execute(_ id: UUID) -> Result<Void, Error> {
        do {
            try self.repository.deleteItem(id)
            return .success(())
        } catch {
            return .failure(ItemError.deleteItemError)
        }
    }
}
