//
//  MoviesTableViewCell.swift
//  Flicks
//
//  Created by Daniel Ku on 1/4/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var moviePosterImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
