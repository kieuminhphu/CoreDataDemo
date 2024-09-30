//
//  DependencyContainer.swift
//  CoreDataDemo
//
//  Created by Kieu Phu on 30/09/2024.
//

import Foundation
import Factory

extension Container {
    var itemLocalRepository: Factory<ItemLocalRepository> {
        Factory(self) {
            CoreDataItemLocalRepository()
        }
    }
    
    var fetchLocalItemsUsecase: Factory<FetchLocalItemsUsecase> {
        Factory(self) {
            FetchLocalItemsUsecaseImpl(repository: self.itemLocalRepository.resolve())
        }
    }
    
    var addLocalItemUsecase: Factory<AddLocalItemUsecase> {
        Factory(self) {
            AddLocalItemUsecaseImpl(repository: self.itemLocalRepository.resolve())
        }
    }
    
    var deleteLocalItemUsecase: Factory<DeleteLocalItemUsecase> {
        Factory(self) {
            DeleteLocalItemUsecaseImpl(repository: self.itemLocalRepository.resolve())
        }
    }
}
