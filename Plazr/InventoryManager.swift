//
//  InventoryManager.swift
//  Plazr
//
//  Created by Colin Rofls on 2015-08-12.
//  Copyright © 2015 cmyr. All rights reserved.
//

import UIKit
import CoreData


class InventoryManager {
    let persistantStore = PersistantStore()

    enum Entities: String {
        case Inventory = "InventoryData"
        case Transaction = "TransactionData"
        case TransactionItem = "TransactionItemData"
    }

    func addDebugInventory() {

        addInventory(.Book, unitCost: 12, title: "Things That Are Fun", artist: "Jack J", publisher: "Plaza Press", art: nil, info: nil)
        addInventory(.Music, unitCost: 10, title: "Dream 2 Science", artist: "Dream 2 Science", publisher: "Rush Hour", art: nil, info: nil)

    }

    func addInventory(
        category: Inventory.Category, unitCost: Float, title: String?, artist: String?, publisher: String?,
        art: UIImage?, info: String?) -> Inventory {
            let newItemStore: InventoryData = NSEntityDescription.insertNewObjectForEntityForName(Entities.Inventory.rawValue, inManagedObjectContext: persistantStore.managedObjectContext) as! InventoryData

            newItemStore.category = category.rawValue
            newItemStore.unit_cost = unitCost
            newItemStore.title = title
            newItemStore.artist = artist
            newItemStore.publisher = publisher
            if let artImage = art {
                newItemStore.art = UIImagePNGRepresentation(artImage)
            }
            newItemStore.stock = 0
            //FIXME: shouldn't be random
            newItemStore.sku = "\(category.skuPrefix)\(random())"

            return Inventory(managedObject: newItemStore)
        }

    func inventoryFetchedResultsController() -> NSFetchedResultsController {
        let request = NSFetchRequest(entityName: Entities.Inventory.rawValue)
        request.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: persistantStore.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
    }
}
