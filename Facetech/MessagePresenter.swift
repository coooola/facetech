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
    fileprivate var prenom : String = ""
    fileprivate var nom : String = ""

    fileprivate var message : Message? = nil {
        didSet{
            if let message = self.message {
                if let fprenom = message.etreEcritPar?.prenom{
                    self.prenom = fprenom.capitalized
                }
                else{ self.prenom = ""}
                
                if let fnom = message.etreEcritPar?.nom{
                    self.nom = fnom.capitalized
                }
                else{ self.nom = ""}
            }
        }
    }
    
    func configure(theCell : MessageTableViewCell?, forMessage: Message?){
        self.message = forMessage
        guard let cell = theCell else { return }
        cell.firstNameLabel.text = self.message?.etreEcritPar?.prenom
        cell.lastNameLabel.text = self.message?.etreEcritPar?.nom
        cell.contentLabel.text = self.message?.contenu
        
    }
}
