//
//  ShoppingListItemsScreen.swift
//  GroceryApp
//
//  Created by Lovelesh Joseph Colaco on 5/8/23.
//

import SwiftUI
import RealmSwift

struct ShoppingListItemsScreen: View {
    
    @ObservedRealmObject var shoppingList: ShoppingList
    @State private var isPresented: Bool = false
    @State private var selectedItemsIds: [ObjectId] = []
    @State private var selectedCategory: String = "All"
    
    var items: [ShoppingItem] {
        if (selectedCategory == "All")
        {
            return Array(shoppingList.items)
            
        }
        else {
            return shoppingList.items.sorted(byKeyPath: "title")
                .filter{
                    $0.category == selectedCategory
                }
        }
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            
            CategoryFilterView(selectedCategory: $selectedCategory)
            
            if items.isEmpty {
                Text("No items found")
            }
            
            List{
                ForEach(items) {
                    item in
                    
                    NavigationLink{
                        AddShoppingListItemScreen(shoppingList: shoppingList,itemToEdit: item)
                    }
                label: {
                    ShoppingItemCell(item: item, selected: selectedItemsIds.contains(item.id)){
                        selected in
                        if selected {
                            selectedItemsIds.append(item.id)
                            if let indexToDelete = shoppingList.items.firstIndex(where: {
                                $0.id == item.id
                            }) {
                                $shoppingList.items.remove(at: indexToDelete)
                            }
                        }
                    }
                }
                    
                    
                }.onDelete(perform: $shoppingList.items.remove)
            }
            
            .navigationTitle(shoppingList.title)
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button {
                    isPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: $isPresented) {
            AddShoppingListItemScreen(shoppingList: shoppingList)
        }
    }
}

struct ShoppingListItemsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ShoppingListItemsScreen(shoppingList: ShoppingList())
        }
    }
}
