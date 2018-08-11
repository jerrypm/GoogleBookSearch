//
//  TableViewCell.swift
//  DaftarBuku
//
//  Created by Jeri Purnama Maulid on 08/08/18.
//  Copyright © 2018 Jeri Purnama Maulid. All rights reserved.
//

import UIKit
import Cosmos

class TableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var starRating: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
