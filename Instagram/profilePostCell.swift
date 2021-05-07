//
//  profilePostCell.swift
//  Instagram
//
//  Created by Vivian Ross on 5/6/21.
//

import UIKit

class profilePostCell: UITableViewCell {

    @IBOutlet weak var profilePostImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profilePostCaption: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
