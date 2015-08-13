//
//  InventoryControllerDataSource.swift
//  Plazr
//
//  Created by Colin Rofls on 2015-08-12.
//  Copyright © 2015 cmyr. All rights reserved.
//

import UIKit
import CoreData


class InventoryControllerDataSource: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate, UISearchBarDelegate {
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

    func itemForIndexPath(indexPath: NSIndexPath) -> Inventory? {
        if let data = fetchedResultsController.objectAtIndexPath(indexPath) as? InventoryData {
            return Inventory(managedObject: data)
        }
        return nil
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(inventoryCellIdentifier, forIndexPath: indexPath) as! InventoryTableViewCell
        cell.inventoryItem = itemForIndexPath(indexPath)
        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }

    // MARK: Search

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            fetchedResultsController.fetchRequest.predicate = NSPredicate(
                format: "(title contains[cd] %@) OR (artist contains[cd] %@)", searchText, searchText)
        } else {
            fetchedResultsController.fetchRequest.predicate = nil
        }

        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch let error as NSError {
            print("error performing fetch \(error)")
        }
    }
}
