//
//  EvenementTableViewCell.swift
//  Facetech
//
//  Created by Polytech on 21/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit

class EvenementTableViewCell: UITableViewCell {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var heureLabel: UILabel!
    @IBOutlet weak var nomEventLabel: UILabel!
    
    //MARK: - UIViewController function -

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
