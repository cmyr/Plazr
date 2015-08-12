//
//  InventoryData+CoreDataProperties.swift
//  Plazr
//
//  Created by Colin Rofls on 2015-08-12.
//  Copyright © 2015 cmyr. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension InventoryData {

    @NSManaged var category: Int16
    @NSManaged var title: String?
    @NSManaged var artist: String?
    @NSManaged var publisher: String?
    @NSManaged var unit_cost: Float
    @NSManaged var art: NSData?
    @NSManaged var buyer: Int16
    @NSManaged var sku: String?
    @NSManaged var info: String?
    @NSManaged var stock: Int16
    @NSManaged var transactions: NSSet?

}
