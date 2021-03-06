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
    var movie: Movie!{
        didSet{
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            
            let posterURL = URL(string: movie.baseURLString + movie.posterPath)!
            posterImageView.af_setImage(withURL: posterURL)
        }
    }
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
