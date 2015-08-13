//
//  InventoryDetailsViewController.swift
//  Plazr
//
//  Created by Colin Rofls on 2015-08-12.
//  Copyright © 2015 cmyr. All rights reserved.
//

import UIKit

class InventoryDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var priceStockLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var publisherLabel: UILabel!

    var item: Inventory? {
        didSet {
            guard titleLabel != nil else {
                return
            }
            setup()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        infoLabel.text = item?.info
        artistLabel.text = item?.artist
        titleLabel.text = item?.title
        imageView.image = item?.art
        publisherLabel.text = item?.publisher
        priceStockLabel.text = "$\(item?.retailCost ?? -1) / \(item?.stock ?? -1) in stock"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
