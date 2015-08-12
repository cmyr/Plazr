//
//  InventoryViewController.swift
//  Plazr
//
//  Created by Colin Rofls on 2015-08-12.
//  Copyright © 2015 cmyr. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var inventorySearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    let inventoryManager = InventoryManager()
    var dataSource: InventoryControllerDataSource?


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        inventoryManager.addDebugInventory()
        dataSource = InventoryControllerDataSource(tableView: tableView)
        dataSource?.fetchedResultsController = inventoryManager.inventoryFetchedResultsController()

        inventorySearchBar.delegate = dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        inventorySearchBar.resignFirstResponder()
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        inventorySearchBar.resignFirstResponder()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
