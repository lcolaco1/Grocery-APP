//
//  Migrator.swift
//  GroceryApp
//
//  Created by Lovelesh Joseph Colaco on 5/8/23.
//

import Foundation
import RealmSwift

class Migrator {
    init() {
        updateschema()
    }
    
    func updateschema() {
        let config = Realm.Configuration(schemaVersion: 2) {
            migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                
                migration.enumerateObjects(ofType: ShoppingList.className()) {_, newObject in
                    newObject!["items"] = List<ShoppingItem>()
                }
            }
            if oldSchemaVersion < 2 {
                migration.enumerateObjects(ofType: ShoppingList.className()) {_, newObject in
                    newObject!["category"] = ""
                }
            }
        }
        
        Realm.Configuration.defaultConfiguration = config
        let _ = try! Realm()
    }
}
