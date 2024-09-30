//
//  ItemLocalRepository.swift
//  CoreDataDemo
//
//  Created by Kieu Phu on 30/09/2024.
//

import Foundation

protocol ItemLocalRepository {
    func fetchItems() throws -> [Item]
    func addItem(_ item: Item) throws -> Item
    func deleteItem(_ id: UUID) throws
}
