//
//  InventoryViewController.swift
//  Plazr
//
//  Created by Colin Rofls on 2015-08-12.
//  Copyright © 2015 cmyr. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController, UITableViewDelegate {

    enum Segues: String {
        case Info = "inventoyDetailsSegue"
    }

    @IBOutlet weak var inventorySearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    let inventoryManager = InventoryManager()
    var dataSource: InventoryControllerDataSource?
    var selected: NSIndexPath?
    var itemsInCart = [Inventory]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "820Inventory"

        showInvoiceButton()

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

    override func viewWillAppear(animated: Bool) {
        if let deselect = selected {
            tableView.deselectRowAtIndexPath(deselect, animated: false)
        }
    }
    //MARK: Interactions

    func invoiceButtonAction(sender: UIBarButtonItem?) {

    }

    //MARK: Private

    private func showInvoiceButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: "invoiceButtonAction:")
        self.navigationItem.rightBarButtonItem?.enabled = itemsInCart.count > 0
    }

    private func showInfo(forIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(Segues.Info.rawValue, sender: indexPath)
    }

    //MARK: TableViewDelegate

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let addAction = UITableViewRowAction(
            style: .Normal,
            title: "Buy") { [weak self](action, indexPath) -> Void in
                if let strongSelf = self {
                    if let item = strongSelf.dataSource?.itemForIndexPath(indexPath) {
                        strongSelf.itemsInCart.append(item)
                    }
                    strongSelf.tableView.setEditing(false, animated: true)
                }
        }
        addAction.backgroundColor = UIColor(red: 107/255, green: 192/255, blue: 130/255, alpha: 1.0)

        let infoAction = UITableViewRowAction(
            style: .Normal,
            title: "info") { [weak self] (action, indexPath) -> Void in
                if let strongSelf = self {
                    strongSelf.showInfo(forIndexPath: indexPath)
                    strongSelf.tableView.setEditing(false, animated: true)
                }
        }
        infoAction.backgroundColor = UIColor.grayColor()

        return [infoAction, addAction]
    }


    func scrollViewDidScroll(scrollView: UIScrollView) {
        inventorySearchBar.resignFirstResponder()
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier ?? "" {
        case "inventoyDetailsSegue":
            let destination = segue.destinationViewController as? InventoryDetailsViewController
            if let idx = sender as? NSIndexPath {
                destination?.item = dataSource?.itemForIndexPath(idx)
            }

        default:
            break
        }
    }

}
