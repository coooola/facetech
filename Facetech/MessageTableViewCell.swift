//
//  MessageTableViewCell.swift
//  Facetech
//
//  Created by Julia Favrel on 02/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    // Les label d'une vue
    @IBOutlet weak var groupsLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var contenuMsg: UITextView!
    
    
    // Initialization code
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // Configure the view for the selected state
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
