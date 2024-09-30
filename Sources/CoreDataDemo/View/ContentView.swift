//
//  ContentView.swift
//  CoreDataDemo
//
//  Created by Kieu Phu on 29/09/2024.
//

import SwiftUI
import CoreData

struct ItemViewModel: Identifiable {
    let id: UUID
    let timestamp: String
}

struct ContentView: View {

    @StateObject var viewModel: ContentViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp)")
                    } label: {
                        VStack {
                            Text(item.id.uuidString)
                            Text(item.timestamp)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            viewModel.addItem(Date())
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for offset in offsets {
                let item = viewModel.items[offset]
                viewModel.deleteItem(item.id)
            }
        }
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
