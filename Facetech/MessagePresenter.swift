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
    
    /// Met une majuscule au nom et prenom
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
    
    /// Configure la cellule de chaque message, récupère les données du message à afficher et les distribu aux différents labels
    ///
    /// - Parameters:
    ///   - theCell: La cellule où le message sera affiché
    ///   - forMessage: Le message a affiche
    func configure(theCell : MessageTableViewCell?, forMessage: Message?)
    {
        // Récuperation et concaténation des groupes auquels ont été lié le message
        
        self.message = forMessage
        guard let cell = theCell else { return }
        
        let types = self.message?.etreLieTypeUtilisateur?.objectEnumerator()
        var typesString : String = ""
        var value : TypeUtilisateur? = types?.nextObject() as? TypeUtilisateur
        
        while (value != nil) {
            let type = value!.libelleTypeUtilisateur
            typesString = typesString + type! + ", "
            value = types?.nextObject() as? TypeUtilisateur
        }
        
        let annees = self.message?.etreLieAnne?.objectEnumerator()
        
        var valueA : AnneePromo? = annees?.nextObject() as? AnneePromo
        
        while (valueA != nil) {
            let annee = valueA!.annee
            typesString = typesString + annee.description + "A, "
            valueA = annees?.nextObject() as? AnneePromo
        }
        
        if (typesString != "")
        {
            typesString.remove(at: typesString.index(before: typesString.endIndex))
            typesString.remove(at: typesString.index(before: typesString.endIndex))
        }
        
        cell.firstNameLabel.text = self.message?.etreEcritPar?.prenom
        cell.lastNameLabel.text = self.message?.etreEcritPar?.nom
        cell.contenuMsg.text = self.message?.contenu
        cell.dateLabel.text = self.message?.date
        cell.groupsLabel.text = typesString
        cell.hourLabel.text = self.message?.time
        
        
    }
}
