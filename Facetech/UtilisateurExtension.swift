//
//  UtilisateurModel.swift
//  Facetech
//
//  Created by Nicolas BITAN on 08/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import CoreData

extension Utilisateur{
    
    static func createUtilisateur(mail: String, nom: String, prenom: String) -> Utilisateur
    {
        let newUser = Utilisateur(context : CoreDataManager.context)
        newUser.adresseMail = mail
        newUser.nom = nom
        newUser.prenom = prenom
        newUser.motDePasse = prenom + "." + nom
        
        return newUser
        
    }
    
    

    
}
