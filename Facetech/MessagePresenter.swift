//
//  MessagePresenter.swift
//  Facetech
//
//  Created by Julia Favrel on 06/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation

class MessagePresenter: NSObject {
    fileprivate var contenu :  String = ""

    fileprivate var message : Message? = nil {
        didSet{
            if let message = self.message {
                if let fcontenu = message.contenu{
                    self.contenu = fcontenu.capitalized
                }
                else{ self.contenu = " - "}
            }
            else {
                self.contenu = ""
            }
        }
    }
    
    func configure(theCell : MessageTableViewCell?, forMessage: Message?){
        self.message = forMessage
        guard let cell = theCell else { return }
        cell.contentLabel.text = self.contenu
    }
}
