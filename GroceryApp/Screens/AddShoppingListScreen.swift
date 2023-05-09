//
//  AddShoppingListScreen.swift
//  GroceryApp
//
//  Created by Lovelesh Joseph Colaco on 5/8/23.
//

import SwiftUI
import RealmSwift

struct AddShoppingListScreen: View {
    
    @State private var title:String = ""
    @State private var address:String = ""
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedResults(ShoppingList.self) var shoppingLists
    
    
    
    var body: some View {
        NavigationView{
            
            Form{
                TextField("Enter Title", text:$title)
                TextField("Enter address",text:$address)
                
                Button {
                    //dismiss()
                    //craete shopping list record
                    let shoppingList = ShoppingList()
                    shoppingList.title = title
                    shoppingList.address = address
                    
                    $shoppingLists.append(shoppingList)
                    
                    
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }.buttonStyle(.bordered)
            }
            .navigationTitle("New List")
        }
    }
}

struct AddShoppingListScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddShoppingListScreen()
    }
}
