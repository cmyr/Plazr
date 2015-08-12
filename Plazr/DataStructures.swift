//
//  DataStructures.swift
//  Plazr
//
//  Created by Colin Rofls on 2015-08-12.
//  Copyright © 2015 cmyr. All rights reserved.
//

import UIKit

struct Inventory {

    enum Category: Int16 {
        case Book
        case Music

        var skuPrefix: String {
            switch self {
            case .Book:
                return "b-"
            case .Music:
                return "m-"
            }
        }
    }

    let category: Category
    let title: String?
    let artist: String?
    let publisher: String?
    let unitCost: Float
    let retailCost: Float
    let art: UIImage?
    let sku: String
    let info: String?
    let stock: Int16
//    let transactions: NSSet?

    init(managedObject: InventoryData) {
        category = Category(rawValue: managedObject.category)!
        title = managedObject.title
        artist = managedObject.artist
        publisher = managedObject.publisher
        unitCost = managedObject.unit_cost
        //FIXME: I don't exist in CD yet
        retailCost = 25
        sku = managedObject.sku!
        info = managedObject.info
        stock = managedObject.stock

        if let data = managedObject.art {
            art = UIImage(data: data)
        } else {
            art = nil
        }
    }
}


struct TransactionItem {
    let date: NSDate
    let quantity: Int16
    let price: Float
    let _itemData: InventoryData?
    let _transactionData: TransactionData?

    lazy var item: Inventory? = {
        if let data = self._itemData {
            return Inventory(managedObject: data)
        } else {
            return nil
        }
    }()

    lazy var transaction: Transaction? = {
        if let data = self._transactionData {
            return Transaction(managedObject: data)
        } else {
            return nil
        }
        }()


    init(managedObject: TransactionItemData) {
        date = NSDate(timeIntervalSinceReferenceDate: managedObject.date)
        quantity = managedObject.quantity
        price = managedObject.price
        _itemData = managedObject.item
        _transactionData = managedObject.transaction

    }
}

struct Transaction {
    let date: NSDate
    let _clientData: CustomerData?
//    let client: Customer?
    let items: Array<TransactionItemData>?

    init(managedObject: TransactionData) {
        date = NSDate(timeIntervalSinceReferenceDate: managedObject.date)
        _clientData = managedObject.client
        items = managedObject.items?.map { $0 } as? [TransactionItemData]
    }
}

struct Customer {

    struct Interests: OptionSetType {
        let rawValue: Int16

        static let Books = Interests(rawValue: 1)
        static let Records = Interests(rawValue: 2)
        static let Events = Interests(rawValue: 4)
    }

    let name: String?
    let email: String?
    let interests: Interests
    let purchases: Array<Int>?

    init(managedObject: CustomerData) {
        name = managedObject.name
        email = managedObject.email
        interests = Interests(rawValue: managedObject.interests)
        purchases = nil
    }
}

