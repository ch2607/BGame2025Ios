//
//  GamesTableViewCell.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 5/27/19.
//  Copyright © 2019 Carl Hsieh. All rights reserved.
//

import UIKit

class GamesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var MyImage: UIImageView!
    @IBOutlet weak var MyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
