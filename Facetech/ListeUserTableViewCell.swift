//
//  ListeUserTableViewCell.swift
//  Facetech
//
//  Created by Julia Favrel on 26/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit

class ListeUserTableViewCell: UITableViewCell {

    //MARK: - OUTLETS -
    
    @IBOutlet weak var nomLabel: UILabel!
    @IBOutlet weak var prenomLabel: UILabel!
    
    
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
