//
//  MovieCell.swift
//  Flix
//
//  Created by Jorge Garcia on 9/27/20.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var SynopsisLabel: UILabel!
    
    @IBOutlet weak var PosterLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
