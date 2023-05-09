//
//  ShoppingItem.swift
//  GroceryApp
//
//  Created by Lovelesh Joseph Colaco on 5/8/23.
//

import Foundation
import RealmSwift

class ShoppingItem: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var quantity: String
    @Persisted var category: String

    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    
}
