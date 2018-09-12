//
//  MovieCell.swift
//  flix
//
//  Created by Vibhu Appalaraju on 9/5/18.
//  Copyright © 2018 Vibhu Appalaraju. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
