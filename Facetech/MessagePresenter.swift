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
    fileprivate var date : Date = Date()
    
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
    
    func configure(theCell : MessageTableViewCell?, forMessage: Message?)
    {
        // Récuperation et concaténation des groupes auquels ont été lié le message
        /*var typesUtilisateur : String = ""
        for i in (message?.etreLieTypeUtilisateur)!
        {
            typesUtilisateur += (i as! TypeUtilisateur).libelleTypeUtilisateur!
            typesUtilisateur += ", "
        }*/
        
        /*let dateMsg = self.message?.datePost
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd-MM-yyyy'T'HH:mm:ssZ"
         let s = dateFormatter.string(from: dateMsg as! Date)
         */
        
        self.message = forMessage
        guard let cell = theCell else { return }
        cell.firstNameLabel.text = self.message?.etreEcritPar?.prenom
        cell.lastNameLabel.text = self.message?.etreEcritPar?.nom
        cell.contentLabel.text = self.message?.contenu
        cell.dateLabel.text = self.message?.date
        //cell.groupsLabel.text = typesUtilisateur
        cell.hourLabel.text = self.message?.time
        
    }
}
