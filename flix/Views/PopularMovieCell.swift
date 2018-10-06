//
//  PopularMovieCell.swift
//  flix
//
//  Created by Vibhu Appalaraju on 10/6/18.
//  Copyright © 2018 Vibhu Appalaraju. All rights reserved.
//

import UIKit

class PopularMovieCell: UITableViewCell {
    
    @IBOutlet weak var popularOverviewLabel: UILabel!
    @IBOutlet weak var popularTitleLabel: UILabel!
    @IBOutlet weak var popularImage: UIImageView!
    
    
    var movie: Movie!{
        didSet{
            popularTitleLabel.text = movie.title
            popularOverviewLabel.text = movie.overview
            
            let posterURL = URL(string: movie.baseURLString + movie.posterPath)!
            popularImage.af_setImage(withURL: posterURL)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
