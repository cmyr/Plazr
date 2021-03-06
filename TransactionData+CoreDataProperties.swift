//
//  TransactionData+CoreDataProperties.swift
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

extension TransactionData {

    @NSManaged var date: NSTimeInterval
    @NSManaged var items: NSSet?
    @NSManaged var client: CustomerData?

}
