//
//  InventoryControllerDataSource.swift
//  Plazr
//
//  Created by Colin Rofls on 2015-08-12.
//  Copyright © 2015 cmyr. All rights reserved.
//

import UIKit
import CoreData


class InventoryControllerDataSource: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    let inventoryCellIdentifier = "inventoryItemCell"
    let tableView: UITableView

    var fetchedResultsController: NSFetchedResultsController! {
        didSet {
            fetchedResultsController.delegate = self
            do {
                try fetchedResultsController.performFetch()
            } catch let error as NSError {
                print("error setting fetched results controller\(error)")
            }
        }
    }

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView.dataSource = self
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(inventoryCellIdentifier, forIndexPath: indexPath) as! InventoryTableViewCell
        if let data = fetchedResultsController.objectAtIndexPath(indexPath) as? InventoryData {
            let inventory = Inventory(managedObject: data)
            cell.inventoryItem = inventory
        } else {
            cell.inventoryItem = nil
        }

        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }

}
