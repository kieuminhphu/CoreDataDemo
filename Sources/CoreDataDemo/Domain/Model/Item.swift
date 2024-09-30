//
//  Item.swift
//  CoreDataDemo
//
//  Created by Kieu Phu on 30/09/2024.
//

import Foundation

struct Item: Identifiable {
    let id: UUID
    let timestamp: Date?
    
    init(id: UUID = UUID(), timestamp: Date?) {
        self.id = id
        self.timestamp = timestamp
    }
}
