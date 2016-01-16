//
//  FeedCell.swift
//  instagram
//
//  Created by Bishal Gautam on 1/14/16.
//  Copyright © 2016 Bishal Gautam. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var myLabel: UILabel!
    
    
    @IBOutlet weak var posterLabel: UIImageView!

        override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
