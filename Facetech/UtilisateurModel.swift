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
    
    static func createUtilisateur(mail: String, nom: String, prenom: String) -> Utilisateur?
    {
        
        let context = CoreDataManager.context
        
        let newUser = Utilisateur(context: context)
        newUser.adresseMail = mail
        newUser.nom = nom
        newUser.prenom = prenom
        newUser.motDePasse = prenom + "." + nom
        
        if let error = CoreDataManager.save()
        {
            //DialogBoxHelper.alert(view: self, error: error)
            return nil
        }
        
        return newUser
        
    }
    
    
    static func getUtilisateur(mail: String? = nil, nom: String? = nil, prenom: String? = nil) -> Utilisateur?
    {
        
        let context = CoreDataManager.context
        
        var user : [Utilisateur] = []
        
        let request : NSFetchRequest<Utilisateur> = Utilisateur.fetchRequest()
        
        request.predicate = NSPredicate(format: "adresseMail == %@", mail!)
        do{
            try user = context.fetch(request)
        }
        catch let error as NSError{
            //DialogBoxHelper.alert(view: self, error: error)
        }
        
        return user.count != 0 ? user[0]: nil
        
    }
    
}
