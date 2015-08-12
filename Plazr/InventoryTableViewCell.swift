//
//  InventoryTableViewCell.swift
//  Plazr
//
//  Created by Colin Rofls on 2015-08-12.
//  Copyright © 2015 cmyr. All rights reserved.
//

import UIKit

class InventoryTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stockCountLabel: UILabel!

    static let defaultThumbnail = UIImage(named: "missing_thumb")

    var inventoryItem: Inventory? {
        didSet {
            thumbnailImageView.image = inventoryItem?.art ?? InventoryTableViewCell.defaultThumbnail
            titleLabel.text = inventoryItem?.title
            artistLabel.text = inventoryItem?.artist
            priceLabel.text = "$\(inventoryItem?.retailCost ?? 0)"
            stockCountLabel.text = "\(inventoryItem?.stock ?? 0)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }



}
